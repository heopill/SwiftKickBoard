//
//  SignUpViewController.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/28/25.
//

import UIKit
import SnapKit

// MARK: - SignUpViewController
class SignUpViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.font = Nanum.bold(36)
        label.textColor = .main
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = Nanum.light(14)
        label.textColor = .black
        
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = Nanum.light(14)
        label.textColor = .black
        
        return label
    }()
    
    private let pwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = Nanum.light(14)
        label.textColor = .black
        
        return label
    }()
    
    private let pwLabel2: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = Nanum.light(14)
        label.textColor = .black
        
        return label
    }()
    
    private let nameTextField: UITextField = {
        let tf = UITextField()
        let underLine = UIView()
        underLine.backgroundColor = .black

        tf.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.leading.trailing.bottom.equalToSuperview()
        }
        
        tf.snp.makeConstraints { $0.height.equalTo(30) }

        return tf
    }()
    
    private let idTextField: UITextField = {
        let tf = UITextField()
        let underLine = UIView()
        underLine.backgroundColor = .black

        tf.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.leading.trailing.bottom.equalToSuperview()
        }
        
        tf.snp.makeConstraints { $0.height.equalTo(30) }

        return tf
    }()
    
    private let pwTextField: UITextField = {
        let tf = UITextField()
        let underLine = UIView()
        underLine.backgroundColor = .black

        tf.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.leading.trailing.bottom.equalToSuperview()
        }
        
        tf.snp.makeConstraints { $0.height.equalTo(30) }

        return tf
    }()
    
    private let pwTextField2: UITextField = {
        let tf = UITextField()
        let underLine = UIView()
        underLine.backgroundColor = .black

        tf.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.leading.trailing.bottom.equalToSuperview()
        }
        
        tf.snp.makeConstraints { $0.height.equalTo(30) }

        return tf
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        button.titleLabel?.font = Nanum.bold(24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .main.withAlphaComponent(0.5)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
}

// MARK: - Lifecycle
extension SignUpViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
}

// MARK: - Method
extension SignUpViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let verticalStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 10
            
            [nameLabel, nameTextField, idLabel, idTextField, pwLabel, pwTextField, pwLabel2, pwTextField2]
                .forEach { stackView.addArrangedSubview($0) }
            
            return stackView
        }()
        
        [titleLabel, verticalStackView, signUpButton]
            .forEach { view.addSubview($0) }
        
        verticalStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(verticalStackView.snp.top).offset(-60)
            $0.centerX.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.equalTo(verticalStackView.snp.bottom).offset(60)
            $0.leading.trailing.equalTo(verticalStackView)
        }
        
    }
    
    @objc func signUpButtonTapped(_ sender: UIButton) {
        
    }
    
}
