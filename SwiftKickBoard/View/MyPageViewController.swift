//
//  MyPageViewController.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/28/25.
//

import UIKit
import SnapKit

// MARK: - MyPageViewController
class MyPageViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SWIFT"
        label.font = Nanum.bold(36)
        label.textColor = .main
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Nanum.bold(36)
        label.textColor = .black
        
        return label
    }()
    
    private let helloLabel: UILabel = {
        let label = UILabel()
        label.text = "님, 안녕하세요!"
        label.font = Nanum.light(20)
        label.textColor = .black
        
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = Nanum.light(20)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        let attribute = NSAttributedString(string: "로그아웃",
                                           attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.setAttributedTitle(attribute, for: .normal)
        button.titleLabel?.font = Nanum.bold(14)
        
        return button
    }()
    
    private lazy var mainTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .black
        table.delegate = self
        table.dataSource = self
        
        let header = UIView()
        let defaultTextLabel = UILabel()
        defaultTextLabel.textColor = .white
        defaultTextLabel.font = Nanum.light(18)
        
        let attribute = NSMutableAttributedString(string: "현재 SWIFT를")
        attribute.addAttributes([.font: Nanum.bold(24) as Any], range: ("현재 SWIFT를" as NSString).range(of: "SWIFT"))
        
        defaultTextLabel.attributedText = attribute
        
        header.addSubview(defaultTextLabel)
        defaultTextLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        table.tableHeaderView = header
        
        return table
    }()
    
}

// MARK: - Lifecycle
extension MyPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
}

// MARK: - Method
extension MyPageViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints {
            $0.height.equalTo(300)
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
}

extension MyPageViewController: UITableViewDelegate {
    
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
