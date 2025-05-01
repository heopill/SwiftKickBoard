import UIKit
import NMapsMap
import CoreLocation
import CoreData
import SnapKit

class MainViewController: UIViewController, CLLocationManagerDelegate, NMFMapViewCameraDelegate {

    let locationManager = CLLocationManager()
    var mapView: NMFMapView!

    var kickBoardData: [KickBoardModel] = []
    var kickBoardMarkers: [NMFMarker] = []

    let coredata = CoreData.shared
    private let detailView = KickBoardDetailView()
    private let overlayView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        setupLogoLabel()
        setupGPSButton()
        setupDetailView()
        setupOverlayView()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        readKickBoardData()
        displayKickBoardMarkers()
        detailView.isHidden = true
        overlayView.isHidden = true

    }

    private func setupMapView() {
        mapView = NMFMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.addCameraDelegate(delegate: self)
        view.addSubview(mapView)
    }

    private func setupLogoLabel() {
        let logoLabel = UILabel()
        logoLabel.text = "SWIFT"
        logoLabel.font = Nanum.heavy(36)
        logoLabel.textColor = UIColor.main
        logoLabel.textAlignment = .center
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoLabel)

        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupGPSButton() {
        let gpsButton = UIButton()
        gpsButton.setImage(UIImage(named: "GPS"), for: .normal)
        gpsButton.tintColor = .systemMint
        gpsButton.translatesAutoresizingMaskIntoConstraints = false
        gpsButton.addTarget(self, action: #selector(gpsButtonTapped), for: .touchUpInside)
        view.addSubview(gpsButton)

        NSLayoutConstraint.activate([
            gpsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            gpsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gpsButton.widthAnchor.constraint(equalToConstant: 60),
            gpsButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func setupDetailView() {
        view.addSubview(detailView)
        detailView.isHidden = true

        detailView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(280)
        }
    }


    private func setupOverlayView() {
        overlayView.backgroundColor = .clear
        overlayView.isHidden = true
        view.addSubview(overlayView)
        
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOverlayTap))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleOverlayTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        
        if !detailView.frame.contains(location) {
            print("화면 터치 감지")
            detailView.isHidden = true
            overlayView.isHidden = true
            
            if let tabBarVC = self.parent as? TabBarController {
                tabBarVC.showTabBar()
            }
        }
    }
    
    @objc
    func gpsButtonTapped() {
        guard let location = locationManager.location else { return }

        let coord = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        let cameraUpdate = NMFCameraUpdate(position: NMFCameraPosition(coord, zoom: 16, tilt: 0, heading: 0))
        cameraUpdate.animation = .easeIn

        mapView.moveCamera(cameraUpdate)
        mapView.locationOverlay.location = coord
        mapView.locationOverlay.hidden = false
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

    private func readKickBoardData() {
        kickBoardData = []
        let data = coredata.readAllData()
        for item in data {
            kickBoardData.append(KickBoardModel(id: Int(item.id), lat: item.lat, lon: item.lon))
        }
    }

    private func displayKickBoardMarkers() {
        kickBoardMarkers.forEach { $0.mapView = nil }
        kickBoardMarkers.removeAll()

        for kickBoard in kickBoardData {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: kickBoard.lat, lng: kickBoard.lon)
            marker.iconImage = NMFOverlayImage(name: "markerImage")
            marker.mapView = mapView

            marker.touchHandler = { [weak self] overlay -> Bool in
                guard let self = self else { return false }

                print(" 상세창 표시 ")
                
                self.detailView.isHidden = false
                self.overlayView.isHidden = false

                self.view.bringSubviewToFront(self.overlayView)
                self.view.bringSubviewToFront(self.detailView)
                
                self.detailView.configure(with: kickBoard)
                
                self.detailView.actionButtonTapped = {[weak self] in
                    guard let self = self else {return}
                    print("대여 버튼 눌림 감지")
                    self.detailView.updateStatus(.rented)
                }
                if let tabBarVC = self.parent as? TabBarController {
                    tabBarVC.hideTabBar()
                }

                return true
            }
            kickBoardMarkers.append(marker)
        }
    }
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        let currentZoom = mapView.zoomLevel
        let threshold: Double = 14

        for marker in kickBoardMarkers {
            marker.mapView = currentZoom >= threshold ? mapView : nil
        }
    }
}
