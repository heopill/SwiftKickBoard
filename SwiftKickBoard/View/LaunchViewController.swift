//
//  LaunchViewController.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/30/25.
//

import UIKit
import SnapKit

class LaunchViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "launchImage"))
        imageView.contentMode = .center
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        
        // 여기서 2초 뒤에 로그인 화면으로 전환 가능
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let loginVC = UINavigationController(rootViewController: LoginViewController())
            loginVC.modalTransitionStyle = .crossDissolve
            loginVC.navigationBar.isHidden = true
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
    }
}
