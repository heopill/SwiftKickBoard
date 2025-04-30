//
//  LaunchViewController.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/30/25.
//

import UIKit

class LaunchView: UIView {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center

        imageView.image = UIImage(named: "LaunchImage")

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setUpUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    private func setUpUI() {
        
        self.addSubview(logoImageView)

        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
