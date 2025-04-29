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
        
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    private let separaterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let clickIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "clickIcon")
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: MainTableViewCell.id)
    }
    
    override func prepareForReuse() {
        titleIcon.image = nil
        titleLabel.text = nil
        countLabel.text = nil
        clickIcon.image = nil
    }
    
    func setupUIForDetailTableView() {
        contentView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        
        [titleLabel, separaterView]
            .forEach { contentView.addSubview($0) }
        
        titleLabel.font = Nanum.light(24)
        titleLabel.text = "#0000"
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        separaterView.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func setupUIForMainTableView() {
        contentView.backgroundColor = .black
        
        titleLabel.font = Nanum.bold(24)
        countLabel.font = Nanum.light(20)
        
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
