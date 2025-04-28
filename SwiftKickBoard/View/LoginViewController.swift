//
//  ViewController.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/25/25.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = Nanum.bold(50)
        label.textColor = .black
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(idLabel)
        idLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }


}

