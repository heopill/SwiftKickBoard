//
//  MainTableViewCell.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/29/25.
//

import UIKit
import SnapKit

class MyPageTableViewCell: UITableViewCell {
    
    static let id = "MyPageTableViewCell"
    private var kickBoardData: [KickBoard] = []
    
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
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    override func prepareForReuse() {
        titleIcon.image = nil
        titleLabel.text = nil
        countLabel.text = nil
    }
    
    func detailCellChanges(indexPath: IndexPath, selected: IndexPath?) {
        
        if let selected {
            kickBoardData = CoreData.shared.readAllData()
            let lat = String(format: "%.2f", kickBoardData[indexPath.row].lat)
            let lon = String(format: "%.2f", kickBoardData[indexPath.row].lon)
            
            if selected.row == 0 {
                self.titleLabel.text = "ID: #\(kickBoardData[indexPath.row].id)"
                self.countLabel.text = "(\(lat)), (\(lon))"
                
            } else {
                self.titleLabel.text = "25.04.29"
                
            }
        }
        
    }
    
    func didSelectCellForMain(indexPath: IndexPath, selected: IndexPath?) {
        kickBoardData = CoreData.shared.readAllData()
        
        if indexPath.row == 0 {
            self.titleIcon.image = UIImage(named: "kickboard")
            self.titleLabel.text = "등록한 킥보드"
            self.countLabel.text = "\(kickBoardData.count)개"
            
        } else if indexPath.row == 1 {
            self.titleIcon.image = UIImage(named: "history")
            self.titleLabel.text = "이용내역"
            self.countLabel.text = "~건"
            
        }
        
        if indexPath == selected {
            self.contentView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
            
        } else {
            self.contentView.backgroundColor = .black
            
        }
        
    }
    
    func setUpDetailTableViewCell() {
        contentView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        
        [titleLabel, countLabel, separaterView]
            .forEach { contentView.addSubview($0) }
        
        titleLabel.font = Nanum.bold(24)
        countLabel.font = Nanum.light(24)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        
        separaterView.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func setUpMainTableViewCell() {
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
