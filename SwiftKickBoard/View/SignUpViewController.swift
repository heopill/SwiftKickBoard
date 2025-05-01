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
    
    private let login = LoginManager()
    
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
        underLine.backgroundColor = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)

        tf.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.leading.trailing.bottom.equalToSuperview()
        }
        
        tf.textColor = .black
        tf.snp.makeConstraints { $0.height.equalTo(30) }

        return tf
    }()
    
    private let idTextField: UITextField = {
        let tf = UITextField()
        let underLine = UIView()
        underLine.backgroundColor = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)

        tf.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.leading.trailing.bottom.equalToSuperview()
        }
        
        tf.textColor = .black
        tf.snp.makeConstraints { $0.height.equalTo(30) }

        return tf
    }()
    
    private let pwTextField: UITextField = {
        let tf = UITextField()
        let underLine = UIView()
        underLine.backgroundColor = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)

        tf.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.leading.trailing.bottom.equalToSuperview()
        }
        
        tf.textColor = .black
        tf.isSecureTextEntry = true
        
        tf.snp.makeConstraints { $0.height.equalTo(30) }

        return tf
    }()
    
    private let pwTextField2: UITextField = {
        let tf = UITextField()
        let underLine = UIView()
        underLine.backgroundColor = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)

        tf.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.leading.trailing.bottom.equalToSuperview()
        }
        
        tf.textColor = .black
        tf.isSecureTextEntry = true
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
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
        guard let nameText = nameTextField.text,
        let idText = idTextField.text,
        let pwText = pwTextField.text,
        let pw2Text = pwTextField2.text else { return }
        
        var message = ""
        
        if nameText.isEmpty {
            message = "이름을 입력해주세요."
        } else if idText.isEmpty {
            message = "아이디를 입력해주세요."
        } else if pwText.isEmpty || pw2Text.isEmpty {
            message = "비밀번호를 입력해주세요."
        } else if pwText != pw2Text {
            message = "비밀번호 두개를 동일하게 입력해주세요."
        }
        
        guard message.isEmpty else {
            let alert = UIAlertController(title: "알림🔔", message: message, preferredStyle: .alert)
            
            present(alert, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                alert.dismiss(animated: true)
            }
            return
        }
        
        guard self.login.signUp(name: nameText, id: idText, pw: pwText, on: self) else { return }
        
        let alert = UIAlertController(title: "알림🔔", message: "회원가입을 성공적으로 완료했습니다.", preferredStyle: .alert)
        
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            alert.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      view.self.endEditing(true)
    }
    
}
