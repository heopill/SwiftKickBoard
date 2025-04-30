import UIKit
import NMapsMap
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var mapView: NMFMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = NMFMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        
        let logoLabel = UILabel()
        logoLabel.text = "SWIFT"
        logoLabel.font = Nanum.bold(36)
        logoLabel.textColor = .systemMint
        logoLabel.textAlignment = .center
        view.addSubview(logoLabel)
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gpsButton = UIButton()
        gpsButton.setImage(UIImage(named: "GPS"), for: .normal)
        gpsButton.tintColor = .systemMint
        gpsButton.addTarget(self, action: #selector(gpsButtonTapped), for: .touchUpInside)
        gpsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gpsButton)
        NSLayoutConstraint.activate([
            gpsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            gpsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gpsButton.widthAnchor.constraint(equalToConstant: 60),
            gpsButton.heightAnchor.constraint(equalToConstant: 60)
        ])
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
}
