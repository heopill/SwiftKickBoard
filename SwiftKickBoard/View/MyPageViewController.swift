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
    
    var selectedMainTableIndex: IndexPath?
    private var detailTableViewCount = 0
    private var kickBoardData: [KickBoard] = []
    private var historyData: [[String]] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SWIFT"
        label.font = Nanum.heavy(36)
        label.textColor = .main
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Nanum.bold(36)
        label.textColor = .black
        label.text = "홍길동"
        
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
        label.text = "abc0000"
        
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        let attribute = NSAttributedString(string: "로그아웃",
                                           attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.setAttributedTitle(attribute, for: .normal)
        button.titleLabel?.font = Nanum.bold(16)
        button.titleLabel?.textColor = UIColor(red: 148/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var mainTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .black
        table.delegate = self
        table.dataSource = self
        table.register(MyPageMainTableViewCell.self, forCellReuseIdentifier: MyPageMainTableViewCell.id)
        table.register(MyPageTableViewHeader.self, forHeaderFooterViewReuseIdentifier: MyPageTableViewHeader.id)
        
        return table
    }()
    
    private lazy var kickBoardTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        table.delegate = self
        table.dataSource = self
        table.register(MyPageKickBoardTableViewCell.self, forCellReuseIdentifier: MyPageKickBoardTableViewCell.id)
        table.isHidden = true
        
        return table
    }()
    
    private lazy var historyTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        table.delegate = self
        table.dataSource = self
        table.register(MyPageHistoryTableViewCell.self, forCellReuseIdentifier: MyPageHistoryTableViewCell.id)
        table.isHidden = true
        
        return table
    }()
    
}

// MARK: - Lifecycle
extension MyPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let myInfo = UserDefaults.standard.array(forKey: "lastID") as? [String] else { return }
        nameLabel.text = myInfo[0]
        idLabel.text = myInfo[1]
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.historyData = HistoryManager().fetchHistory()
        self.kickBoardData = CoreData.shared.readAllData()
        
        self.navigationController?.navigationBar.isHidden = true
        self.mainTableView.reloadData()
        self.kickBoardTableView.reloadData()
    }
    
}

// MARK: - Method
extension MyPageViewController {
    
    @objc private func logoutButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        UserDefaults.standard.set(false, forKey: "autoLogin")
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [titleLabel, nameLabel, helloLabel, idLabel, logoutButton, mainTableView, kickBoardTableView, historyTableView]
            .forEach { view.addSubview($0) }
        
        mainTableView.snp.makeConstraints {
            $0.height.equalTo(260)
            $0.centerY.equalToSuperview().offset(-46)
            $0.leading.trailing.equalToSuperview()
        }
        
        kickBoardTableView.snp.makeConstraints {
            $0.top.equalTo(mainTableView.snp.bottom)
            $0.bottom.equalToSuperview().inset(110)
            $0.leading.trailing.equalToSuperview()
        }
        
        historyTableView.snp.makeConstraints {
            $0.top.equalTo(mainTableView.snp.bottom)
            $0.bottom.equalToSuperview().inset(110)
            $0.leading.trailing.equalToSuperview()
        }
        
        idLabel.snp.makeConstraints {
            $0.bottom.equalTo(mainTableView.snp.top).offset(-12)
            $0.leading.equalToSuperview().inset(24)
        }
        
        logoutButton.snp.makeConstraints {
            $0.bottom.equalTo(idLabel)
            $0.trailing.equalToSuperview().inset(8)
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(idLabel.snp.top).offset(-8)
            $0.leading.equalToSuperview().inset(24)
        }
        
        helloLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing)
            $0.bottom.equalTo(nameLabel)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(60)
        }
        
    }
    
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == mainTableView {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageTableViewHeader.id) as? MyPageTableViewHeader else { return UIView() }
            
            header.setState(state: HistoryManager().fetchState())
            return header
            
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == mainTableView {
            let height = tableView.frame.height / 4
            return height
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == mainTableView {
            
            if indexPath.row == 0 {
                kickBoardTableView.isHidden.toggle()
                if !kickBoardTableView.isHidden,
                   !historyTableView.isHidden {
                    historyTableView.isHidden = true
                }
            } else {
                historyTableView.isHidden.toggle()
                if !kickBoardTableView.isHidden,
                   !historyTableView.isHidden {
                    kickBoardTableView.isHidden = true
                }
            }
            
            if kickBoardTableView.isHidden,
               historyTableView.isHidden {
                selectedMainTableIndex = nil
            } else {
                selectedMainTableIndex = indexPath
            }
            
            tableView.reloadData()
            kickBoardTableView.reloadData()
        }
        
    }
    
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == mainTableView {
            return 60
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainTableView {
            return 2
        } else if tableView == kickBoardTableView {
            return kickBoardData.count
        } else {
            return historyData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == mainTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageMainTableViewCell.id, for: indexPath) as? MyPageMainTableViewCell else { return UITableViewCell() }
            
            cell.cellChanges(indexPath: indexPath,
                             selected: selectedMainTableIndex,
                             kickBoardData: kickBoardData,
                             historyData: historyData)
            
            return cell
            
        } else if tableView == kickBoardTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageKickBoardTableViewCell.id, for: indexPath) as? MyPageKickBoardTableViewCell else { return UITableViewCell() }
            
            cell.cellChanges(indexPath: indexPath, kickBoardData: kickBoardData)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageHistoryTableViewCell.id, for: indexPath) as? MyPageHistoryTableViewCell else { return UITableViewCell() }
            
            cell.cellChanges(indexPath: indexPath, historyData: historyData)
            
            return cell
        }
        
    }
    
    
}
