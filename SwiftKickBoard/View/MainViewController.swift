//
//  MainViewController.swift
//  SwiftKickBoard
//

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

    // 주소 입력창
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "주소를 입력하세요",
            attributes: [.foregroundColor: UIColor.gray]
        )
        textField.borderStyle = .roundedRect
        textField.font = Nanum.light(14) ?? .systemFont(ofSize: 14)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 6
        textField.returnKeyType = .search
        return textField
    }()

    // 주소 검색 버튼
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.main
        button.layer.cornerRadius = 6
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        setupLogoLabel()
        setupAddressSearchUI()
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

    // 지도 초기화
    private func setupMapView() {
        mapView = NMFMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.addCameraDelegate(delegate: self)
        view.addSubview(mapView)
    }

    // 상단 로고
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

    // 주소 검색창 및 버튼 레이아웃
    private func setupAddressSearchUI() {
        view.addSubview(addressTextField)
        view.addSubview(searchButton)

        addressTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-8)
            $0.height.equalTo(40)
        }

        searchButton.snp.makeConstraints {
            $0.centerY.equalTo(addressTextField)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(60)
            $0.height.equalTo(40)
        }

        searchButton.addTarget(self, action: #selector(searchAddress), for: .touchUpInside)
        addressTextField.delegate = self
    }

    // GPS 버튼
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

    // 킥보드 상세창
    private func setupDetailView() {
        view.addSubview(detailView)
        detailView.isHidden = true

        detailView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(280)
        }
    }

    // 상세창 이외 클릭
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

    // 주소 입력 후 검색 시 위치 이동
    @objc private func searchAddress() {
        guard let keyword = addressTextField.text, !keyword.isEmpty else { return }

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(keyword) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let error = error {
                print("주소 검색 오류: \(error.localizedDescription)")
                return
            }

            guard let location = placemarks?.first?.location else {
                print("검색 결과 없음")
                return
            }

            let coord = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
            cameraUpdate.animation = .easeIn
            self.mapView.moveCamera(cameraUpdate)
        }
    }

    // 터치 시 상세창 닫기
    @objc private func handleOverlayTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)

        if !detailView.frame.contains(location) {
            detailView.isHidden = true
            overlayView.isHidden = true

            if let tabBarVC = self.parent as? TabBarController {
                tabBarVC.showTabBar()
            }
        }
    }

    // GPS 버튼 동작
    @objc func gpsButtonTapped() {
        guard let location = locationManager.location else { return }

        let coord = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        let cameraUpdate = NMFCameraUpdate(position: NMFCameraPosition(coord, zoom: 16, tilt: 0, heading: 0))
        cameraUpdate.animation = .easeIn

        mapView.moveCamera(cameraUpdate)
        mapView.locationOverlay.location = coord
        mapView.locationOverlay.hidden = false
    }

    // 위치 권한 변경 감지
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

    // CoreData에서 킥보드 데이터 불러오기
    private func readKickBoardData() {
        kickBoardData = []
        let data = coredata.readAllData()
        for item in data {
            kickBoardData.append(KickBoardModel(id: Int(item.id), lat: item.lat, lon: item.lon))
        }
    }

    // 킥보드 마커 표시
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

                self.detailView.isHidden = false
                self.overlayView.isHidden = false

                self.view.bringSubviewToFront(self.overlayView)
                self.view.bringSubviewToFront(self.detailView)

                self.detailView.configure(with: kickBoard)

                self.detailView.actionButtonTapped = { [weak self] in
                    guard let self = self else { return }
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

    // 줌 레벨에 따른 마커 표시
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        let currentZoom = mapView.zoomLevel
        let threshold: Double = 14

        for marker in kickBoardMarkers {
            marker.mapView = currentZoom >= threshold ? mapView : nil
        }
    }
}

// 텍스트 필드 검색 실행
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchAddress()
        textField.resignFirstResponder()
        return true
    }
}
