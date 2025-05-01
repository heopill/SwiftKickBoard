//
//  AddViewController.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/28/25.
//

import UIKit
import SnapKit
import CoreData
import NMapsMap

class AddViewController: UIViewController, CLLocationManagerDelegate, NMFMapViewTouchDelegate {
    
    var container: NSPersistentContainer!
    var kickBoardData: [KickBoardModel] = []
    var coredata = CoreData.shared
    let locationManager = CLLocationManager()
    let tempMarker = NMFMarker()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Nanum.heavy(36)
        label.text = "SWIFT"
        label.textColor = UIColor.main
        return label
    }()
    
    lazy var mapView: NMFMapView = {
        
        let mapView = NMFMapView(frame: self.view.frame)
        mapView.touchDelegate = self
        
        return mapView
    }()
    
    private let xTextField: UITextField = {
        let textField = UITextField()
        textField.font = Nanum.light(18)
        textField.textColor = UIColor(red: 148/255.0,
                                      green: 148/255.0,
                                      blue: 148/255.0,
                                      alpha: 1)
        return textField
    }()
    
    // 밑줄 만들기
    private let xUnderLine: UIView = {
        let underLine = UIView()
        underLine.backgroundColor = UIColor(red: 148/255.0,
                                            green: 148/255.0,
                                            blue: 148/255.0,
                                            alpha: 1)
        
        return underLine
    }()
    
    private let yTextField: UITextField = {
        let textField = UITextField()
        textField.font = Nanum.light(18)
        textField.textColor = UIColor(red: 148/255.0,
                                      green: 148/255.0,
                                      blue: 148/255.0,
                                      alpha: 1)
        return textField
    }()
    
    
    // 밑줄 만들기
    private let yUnderLine: UIView = {
        let underLine = UIView()
        underLine.backgroundColor = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)
        
        return underLine
    }()
    
    // 등록하기 버튼
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록하기", for: .normal)
        button.titleLabel?.font = Nanum.bold(24)
        button.backgroundColor = UIColor.main.withAlphaComponent(0.5)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchDown)
        return button
    }()
    
    // GPS 버튼
    lazy var gpsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "GPS"), for: .normal)
        button.tintColor = .systemMint
        button.addTarget(self, action: #selector(gpsButtonTapped), for:     .touchDown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        readData()
        displayKickBoardMarkers(on: mapView, with: kickBoardData)
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        xTextField.attributedPlaceholder = NSAttributedString(string: "위도", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        yTextField.attributedPlaceholder = NSAttributedString(string: "경도", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        
        [titleLabel, mapView, xUnderLine, yUnderLine, xTextField, yTextField, addButton, gpsButton].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(402)
            make.height.equalTo(450)
        }
        
        xTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.top.equalTo(mapView.snp.bottom).offset(45)
            make.width.equalTo(137)
        }
        
        xUnderLine.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.width.equalTo(137)
            make.leading.equalToSuperview().offset(44)
            make.top.equalTo(xTextField.snp.bottom).offset(7)
        }

        yTextField.snp.makeConstraints { make in
            make.leading.equalTo(xTextField.snp.trailing).offset(28)
            make.trailing.equalToSuperview().inset(50)
            make.top.equalTo(mapView.snp.bottom).offset(45)
            make.width.equalTo(137)
        }
        
        yUnderLine.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.width.equalTo(137)
            make.leading.equalTo(xUnderLine.snp.trailing).offset(27)
            make.top.equalTo(yTextField.snp.bottom).offset(7)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(xUnderLine.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(46)
            make.trailing.equalToSuperview().inset(46)
            make.height.equalTo(55)
        }
        
        gpsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(mapView.snp.bottom).inset(10)
            make.width.height.equalTo(30)
        }
    }
    
    // 등록하기 버튼 클릭 이벤트
    @objc private func addButtonTapped() {
        print("등록하기 버튼 클릭")
        guard let xText = xTextField.text, let x = Double(xText) else { return }
        guard let yText = yTextField.text, let y = Double(yText) else { return }
        
        let nextId = (kickBoardData.map { $0.id }.max() ?? 0) + 1
        
        coredata.createData(id: nextId, lat: x, lon: y)
        readData()
        
        displayKickBoardMarkers(on: mapView, with: kickBoardData)
        
        let alert = UIAlertController(title: "등록 완료", message: "\(nextId)번 킥보드가 등록되었습니다!", preferredStyle: .alert)
        
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            alert.dismiss(animated: true)
        }
        
        xTextField.text = nil
        yTextField.text = nil
    }
    
    // gps 버튼 클릭 이벤트
    @objc func gpsButtonTapped() {
        print("gps 버튼 클릭")
        guard let location = locationManager.location else { return }

        let coord = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        let cameraUpdate = NMFCameraUpdate(position: NMFCameraPosition(coord, zoom: 16, tilt: 0, heading: 0))
        cameraUpdate.animation = .easeIn

        mapView.moveCamera(cameraUpdate)

        mapView.locationOverlay.location = coord
        mapView.locationOverlay.hidden = false
    }
    
    // 화면 아무곳이나 터치하면 키보드가 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.self.endEditing(true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    // 지도에 마커를 추가하는 함수
    private func displayKickBoardMarkers(on mapView: NMFMapView, with data: [KickBoardModel]) {
        tempMarker.mapView = nil
        
        for kickBoard in data {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: kickBoard.lat, lng: kickBoard.lon)
            marker.iconImage = NMFOverlayImage(name: "markerImage")
            marker.mapView = mapView
        }
    }
    
    // 데이터를 읽어오고 배열에 저장
    private func readData() {
        kickBoardData = []
        let kickBoard = coredata.readAllData()
        
        for data in kickBoard {
            kickBoardData.append(KickBoardModel(id: Int(data.id),lat: data.lat, lon: data.lon))
        }
    }
    
    // 지도를 클릭하면 호출되는 델리게이트 메서드
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        let lat = latlng.lat
        let lon = latlng.lng
        
        print("지도 클릭 : 위도 \(lat), 경도 \(lon)")
        
        xTextField.text = "\(lat)"
        yTextField.text = "\(lon)"
        
        tempMarker.position = NMGLatLng(lat: lat, lng: lon)
        tempMarker.iconImage = NMFOverlayImage(name: "tempMarkerImage")
        tempMarker.anchor = CGPoint(x: -1, y: -1)
        tempMarker.mapView = mapView
    }
    
}

