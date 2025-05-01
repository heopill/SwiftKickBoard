//
//  MyPageTableViewHeader.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/30/25.
//

import UIKit
import SnapKit

class MyPageTableViewHeader: UITableViewHeaderFooterView {
    
    static let id = "MyPageTableViewHeader"
    
    private let titleText = "현재 SWIFT를"
    private let titleHighlight = "SWIFT"
    
    private let defaultTextLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = Nanum.bold(22)
        
        return label
    }()
    
    private let stateTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .main
        label.font = Nanum.bold(22)
        label.text = "이용 중"
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    func setHeaderText() {
        
        let attribute = NSMutableAttributedString(string: titleText)
        attribute.addAttributes([.font: Nanum.heavy(34) as Any], range: (titleText as NSString).range(of: titleHighlight))
        attribute.addAttributes([.foregroundColor: UIColor(.main) as Any], range: (titleText as NSString).range(of: titleHighlight))
        
        defaultTextLabel.attributedText = attribute
        
    }
    
    func setState(state: Bool) {
        stateTextLabel.text = state ? "이용 중" : "찾는 중"
    }
    
    private func setUpUI() {
        contentView.addSubview(defaultTextLabel)
        contentView.addSubview(stateTextLabel)
        
        defaultTextLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        stateTextLabel.snp.makeConstraints {
            $0.bottom.equalTo(defaultTextLabel.snp.bottom)
            $0.leading.equalTo(defaultTextLabel.snp.trailing).offset(8)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
