import UIKit
import NMapsMap
import CoreLocation
import CoreData

class MainViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var mapView: NMFMapView!
    
    var kickBoardData: [KickBoardModel] = []
    let coredata = CoreData.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        setupLogoLabel()
        setupGPSButton()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readKickBoardData()
        displayKickBoardMarkers()
    }

    private func setupMapView() {
        mapView = NMFMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
    }

    private func setupLogoLabel() {
        let logoLabel = UILabel()
        logoLabel.text = "SWIFT"
        logoLabel.font = Nanum.bold(36)
        logoLabel.textColor = .systemMint
        logoLabel.textAlignment = .center
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoLabel)

        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
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
            gpsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            gpsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gpsButton.widthAnchor.constraint(equalToConstant: 60),
            gpsButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc func gpsButtonTapped() {
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
        for kickBoard in kickBoardData {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: kickBoard.lat, lng: kickBoard.lon)
            marker.iconImage = NMFOverlayImage(name: "markerImage")
            marker.mapView = mapView
        }
    }
}
