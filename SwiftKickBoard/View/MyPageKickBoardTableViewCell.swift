//
//  MyPageDetailTableViewCell.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/30/25.
//

import UIKit
import SnapKit

class MyPageKickBoardTableViewCell: UITableViewCell {
    
    static let id = "MyPageKickBoardTableViewCell"
    
    let leadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    let trailingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    private let separaterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    override func prepareForReuse() {
        leadingLabel.text = nil
        trailingLabel.text = nil
    }
    
    func cellChanges(indexPath: IndexPath, kickBoardData: [KickBoard]) {
        
        let lat = String(format: "%.2f", kickBoardData[indexPath.row].lat)
        let lon = String(format: "%.2f", kickBoardData[indexPath.row].lon)
        
        self.leadingLabel.text = "ID: #\(kickBoardData[indexPath.row].id)"
        self.trailingLabel.text = "(\(lat)), (\(lon))"
        
    }
    
    func setUpUI() {
        contentView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        
        [leadingLabel, trailingLabel, separaterView]
            .forEach { contentView.addSubview($0) }
        
        leadingLabel.font = Nanum.bold(24)
        trailingLabel.font = Nanum.light(24)
        
        leadingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        trailingLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        
        separaterView.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
