//
//  ViewController.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/25/25.
//

import UIKit
import SnapKit

// MARK: - LoginViewController
class LoginViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SWIFT"
        label.font = Nanum.bold(36)
        label.textColor = .main
        
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
    
    private let idTextField: UITextField = {
        let tf = UITextField()
        let underLine = UIView()
        underLine.backgroundColor = .black
        
        tf.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.leading.trailing.bottom.equalToSuperview()
        }
        
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
        
        return tf
    }()
    
    private lazy var autoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 로그인 유지", for: .normal)
        button.titleLabel?.font = Nanum.light(12)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "checkEmpty"), for: .normal)
        button.setImage(UIImage(named: "checkFill"), for: .selected)
        button.addTarget(self, action: #selector(autoLoginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var findPWButton: UIButton = {
        let button = UIButton()
        let attribute = NSAttributedString(string: "비밀번호 찾기",
                                           attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.setAttributedTitle(attribute, for: .normal)
        button.titleLabel?.font = Nanum.light(12)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(findPWButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var findIDButton: UIButton = {
        let button = UIButton()
        let attribute = NSAttributedString(string: "아이디 찾기",
                                           attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.setAttributedTitle(attribute, for: .normal)
        button.titleLabel?.font = Nanum.light(12)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(findIDButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        let attribute = NSAttributedString(string: "회원가입",
                                           attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.setAttributedTitle(attribute, for: .normal)
        button.titleLabel?.font = Nanum.light(12)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = Nanum.bold(20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .main.withAlphaComponent(0.5)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let eazyLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "간편로그인"
        label.font = Nanum.light(12)
        label.textColor = .lightGray
        label.backgroundColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var eazyLoginButtonStackView: UIStackView = {
        let apple = UIButton()
        let google = UIButton()
        let kakao = UIButton()
        
        apple.setImage(UIImage(named: "apple"), for: .normal)
        google.setImage(UIImage(named: "google"), for: .normal)
        kakao.setImage(UIImage(named: "kakao"), for: .normal)
        [apple, google, kakao].forEach {
            $0.addTarget(self, action: #selector(eazyLoginButtonTapped), for: .touchUpInside)
        }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 60
        ([apple, google, kakao] as [UIView]).forEach{ stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
}

// MARK: - Lifecycle
extension LoginViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

// MARK: - Method
extension LoginViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [titleLabel, idLabel, pwLabel, idTextField, pwTextField, autoLoginButton, findPWButton, signUpButton, findIDButton, loginButton, separateView, eazyLoginLabel, eazyLoginButtonStackView]
            .forEach { view.addSubview($0) }
        
        pwTextField.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.centerY)
            $0.height.equalTo(30)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        pwLabel.snp.makeConstraints {
            $0.bottom.equalTo(pwTextField.snp.top).offset(-4)
            $0.leading.equalTo(pwTextField)
        }
        
        idTextField.snp.makeConstraints {
            $0.bottom.equalTo(pwLabel.snp.top).offset(-28)
            $0.leading.trailing.height.equalTo(pwTextField)
        }
        
        idLabel.snp.makeConstraints {
            $0.bottom.equalTo(idTextField.snp.top).offset(-4)
            $0.leading.equalTo(idTextField)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(idLabel.snp.top).offset(-72)
        }
        
        autoLoginButton.snp.makeConstraints {
            $0.leading.equalTo(pwTextField)
            $0.top.equalTo(pwTextField.snp.bottom).offset(4)
        }
        
        findPWButton.snp.makeConstraints {
            $0.trailing.equalTo(pwTextField)
            $0.top.equalTo(pwTextField.snp.bottom)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.equalTo(pwTextField.snp.bottom).offset(56)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
//        signUpButton.snp.makeConstraints {
//            $0.top.equalTo(loginButton.snp.bottom).offset(16)
//            $0.trailing.equalTo(view.snp.centerX).offset(-30)
//        }
//        
//        findIDButton.snp.makeConstraints {
//            $0.top.equalTo(signUpButton)
//            $0.leading.equalTo(view.snp.centerX).offset(30)
//        }
        
        let stackView = UIStackView(arrangedSubviews: [signUpButton, findIDButton])
        stackView.axis = .horizontal
        stackView.spacing = 60
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        separateView.snp.makeConstraints {
            $0.height.equalTo(0.3)
            $0.top.equalTo(stackView.snp.bottom).offset(24)
            $0.leading.trailing.equalTo(pwTextField)
        }
        
        eazyLoginLabel.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.center.equalTo(separateView)
        }
        
        eazyLoginButtonStackView.snp.makeConstraints {
            $0.top.equalTo(eazyLoginLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func autoLoginButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @objc func findPWButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc func loginButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc func findIDButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc func signUpButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc func eazyLoginButtonTapped(_ sender: UIButton) {
        
    }
    
}
