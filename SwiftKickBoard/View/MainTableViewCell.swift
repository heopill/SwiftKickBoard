//
//  MainTableViewCell.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/29/25.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    static let id = "MainTableViewCell"
    
    let titleIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Nanum.bold(24)
        
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Nanum.light(20)
        
        return label
    }()
    
    private let clickIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "clickIcon")
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: MainTableViewCell.id)
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        
        [titleIcon, titleLabel, countLabel, clickIcon]
            .forEach { contentView.addSubview($0) }
        
        titleIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleIcon.snp.trailing).offset(8)
        }
        
        clickIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(clickIcon.snp.leading)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
