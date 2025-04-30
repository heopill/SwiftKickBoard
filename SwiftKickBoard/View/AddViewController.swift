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

class AddViewController: UIViewController {
    
    var container: NSPersistentContainer!
    var kickBoardData: [KickBoardModel] = []
    var coredata = CoreData.shared
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Nanum.bold(36)
        label.text = "SWIFT"
        label.textColor = UIColor.main
        return label
    }()
    
    lazy var mapView: NMFMapView = {
        
        let mapView = NMFMapView(frame: self.view.frame)
        
        let cameraPosition = NMFCameraPosition(
            NMGLatLng(lat: 37.557116, lng: 126.924353), // 좌표
            zoom: 15.0,    // 줌 레벨
            tilt: 0.0,     // 기울기 (tilt)
            heading: 0.0      // 방향 (bearing)
        )
        
        let cameraUpdate = NMFCameraUpdate(position: cameraPosition)
        mapView.moveCamera(cameraUpdate)
        
        //        let marker = NMFMarker()
        //        marker.position = NMGLatLng(lat: 37.557175, lng: 126.924574)
        //        marker.iconImage = NMFOverlayImage(name: "markerImage")
        //        marker.mapView = mapView
        //
        //        let marker2 = NMFMarker()
        //        marker2.position = NMGLatLng(lat: 37.556520, lng: 126.922885)
        //        marker2.iconImage = NMFOverlayImage(name: "markerImage")
        //        marker2.mapView = mapView
        //
        //        let marker3 = NMFMarker()
        //        marker3.position = NMGLatLng(lat: 37.556154, lng: 126.925167)
        //        marker3.iconImage = NMFOverlayImage(name: "markerImage")
        //        marker3.mapView = mapView
        
        return mapView
    }()
    
    private let xLabel: UILabel = {
        let label = UILabel()
        label.text = "X"
        label.font = Nanum.bold(24)
        label.textColor = UIColor(red: 148/255.0,
                                  green: 148/255.0,
                                  blue: 148/255.0,
                                  alpha: 1)
        
        return label
    }()
    
    private let xTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "위도"
        textField.font = Nanum.light(24)
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
    
    
    private let yLabel: UILabel = {
        let label = UILabel()
        label.text = "Y"
        label.font = Nanum.bold(24)
        label.textColor = UIColor(red: 148/255.0,
                                  green: 148/255.0,
                                  blue: 148/255.0,
                                  alpha: 1)
        
        return label
    }()
    
    private let yTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "경도"
        textField.font = Nanum.light(24)
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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readData()
        displayKickBoardMarkers(on: mapView, with: kickBoardData)
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        [titleLabel, mapView, xLabel, yLabel, xUnderLine, yUnderLine, xTextField, yTextField,addButton,].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(141)
            make.top.equalToSuperview().offset(60)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(402)
            make.height.equalTo(344)
        }
        
        xLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(51)
            make.top.equalTo(mapView.snp.bottom).offset(45)
            make.width.equalTo(18)
        }
        
        xTextField.snp.makeConstraints { make in
            make.leading.equalTo(xLabel.snp.trailing).offset(10)
            make.top.equalTo(mapView.snp.bottom).offset(45)
        }
        
        xUnderLine.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.width.equalTo(137)
            make.leading.equalToSuperview().offset(44)
            make.top.equalTo(xLabel.snp.bottom).offset(7)
        }
        
        yLabel.snp.makeConstraints { make in
            make.leading.equalTo(xLabel.snp.trailing).offset(146)
            make.top.equalTo(mapView.snp.bottom).offset(45)
            make.width.equalTo(18)
        }
        
        yTextField.snp.makeConstraints { make in
            make.leading.equalTo(yLabel.snp.trailing).offset(10)
            make.top.equalTo(mapView.snp.bottom).offset(45)
        }
        
        yUnderLine.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.width.equalTo(137)
            make.leading.equalTo(xUnderLine.snp.trailing).offset(27)
            make.top.equalTo(yLabel.snp.bottom).offset(7)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(xUnderLine.snp.bottom).offset(62)
            make.leading.equalToSuperview().offset(46)
            make.trailing.equalToSuperview().inset(46)
            make.height.equalTo(55)
        }
    }
    
    @objc private func buttonTapped() {
        print("등록하기 버튼 클릭")
        guard let xText = xTextField.text, let x = Double(xText) else { return }
        guard let yText = yTextField.text, let y = Double(yText) else { return }
        
        let nextId = (kickBoardData.map { $0.id }.max() ?? 0) + 1
        
        coredata.createData(id: nextId, lat: x, lon: y)
        readData()
        
        displayKickBoardMarkers(on: mapView, with: kickBoardData)
    }
    
    // 화면 아무곳이나 터치하면 키보드가 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.self.endEditing(true)
    }
    
    // 지도에 마커를 추가하는 함수
    private func displayKickBoardMarkers(on mapView: NMFMapView, with data: [KickBoardModel]) {
        for kickBoard in data {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: kickBoard.lat, lng: kickBoard.lon)
            marker.iconImage = NMFOverlayImage(name: "markerImage")
            marker.mapView = mapView
        }
    }
    
    private func readData() {
        kickBoardData = []
        let kickBoard = coredata.readAllData()
        
        for data in kickBoard {
            kickBoardData.append(KickBoardModel(id: Int(data.id),lat: data.lat, lon: data.lon))
        }
        
    }
    
}


