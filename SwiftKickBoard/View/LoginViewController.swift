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
    
    private let login = LoginManager()
    
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
        underLine.backgroundColor = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)
        
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
        underLine.backgroundColor = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)
        
        tf.addSubview(underLine)
        underLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.leading.trailing.bottom.equalToSuperview()
        }
        
        tf.isSecureTextEntry = true
        
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
        button.setTitleColor(UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1), for: .normal)
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
        label.textColor = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)
        label.backgroundColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)
        
        return view
    }()
    
    private lazy var eazyLoginButtonStackView: UIStackView = {
        let apple = UIButton()
        let google = UIButton()
        let kakao = UIButton()
        
        apple.setImage(UIImage(named: "apple"), for: .normal)
        google.setImage(UIImage(named: "Google"), for: .normal)
        kakao.setImage(UIImage(named: "KAKAO"), for: .normal)
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
        
        if UserDefaults.standard.bool(forKey: "autoLogin") {
            guard let lastID = UserDefaults.standard.array(forKey: "lastID") as? [String] else { return }
            
            if login.login(id: lastID[1], pw: lastID[2]) != nil {
                self.navigationController?.pushViewController(MainViewController(), animated: true)
            }
        }
        
        setupUI()
    }
    
}

// MARK: - Method
extension LoginViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [signUpButton, findIDButton])
        stackView.axis = .horizontal
        stackView.spacing = 60
        view.addSubview(stackView)
        
        [titleLabel, idLabel, pwLabel, idTextField, pwTextField, autoLoginButton, findPWButton, loginButton, separateView, eazyLoginLabel, eazyLoginButtonStackView]
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
        let alert = UIAlertController(title: "비밀번호 찾기", message: "이름과 아이디를 입력해주세요.", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "ID"
        }
        
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            guard let nameTextField = alert.textFields?[0],
            let idTextField = alert.textFields?[1] else { return }
            
            guard let name = nameTextField.text,
            let id = idTextField.text else { return }
            
            self.login.findPW(name: name, id: id, on: self)
        })
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alert, animated: true)
    }
    
    // Login 버튼 클릭
    @objc func loginButtonTapped(_ sender: UIButton) {
        
        if let info = login.login(id: idTextField.text ?? "", pw: pwTextField.text ?? "") {
            
            if autoLoginButton.isSelected {
                UserDefaults.standard.set(true, forKey: "autoLogin")
            } else {
                UserDefaults.standard.set(false, forKey: "autoLogin")
            }
            
            UserDefaults.standard.set(info, forKey: "lastID")
            
            let alert = UIAlertController(title: "알림🔔", message: "로그인 성공!", preferredStyle: .alert)
            
            present(alert, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                alert.dismiss(animated: true)
                self.navigationController?.pushViewController(MainViewController(), animated: true)
            }
            
        } else {
            let alert = UIAlertController(title: "알림🔔", message: "ID 혹은 비밀번호가 일치하지 않습니다.", preferredStyle: .alert)
            
            present(alert, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true)
            }
            
        }
    }
    
    @objc func findIDButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "아이디 찾기", message: "이름을 입력해주세요.", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            guard let textField = alert.textFields?.first else { return }
            guard let text = textField.text else { return }
            
            self.login.findID(name: text, on: self)
        })
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc func signUpButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc func eazyLoginButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "안내🔔", message: "해당 기능은 구현 예정입니다.", preferredStyle: .alert)
        
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            alert.dismiss(animated: true)
        }
    }
    
}
