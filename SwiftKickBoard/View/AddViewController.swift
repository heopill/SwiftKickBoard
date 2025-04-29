//
//  AddViewController.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/28/25.
//

import UIKit
import SnapKit

class AddViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Nanum.bold(36)
        label.text = "SWIFT"
        label.textColor = UIColor.main
        return label
    }()
    
    private let mapView: UIView = {
        let mapView = UIView()
        mapView.backgroundColor = .cyan
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
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
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
    
   
    
}


