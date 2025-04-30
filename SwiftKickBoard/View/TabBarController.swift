//
//  TapBarController.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/30/25.
//

import UIKit
import SnapKit

// MARK: - TabBarController
class TabBarController: UIViewController {
    
    private var selectedIndex = 0
    private var tabBarItems: [UIButton] = []
    private var viewControllers: [UIViewController] = []
    
    private let tabBar: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 42
        
        return view
    }()
    
    private let mainViewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "map"), for: .normal)
        
        return button
    }()
    
    private let addViewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        
        return button
    }()
    
    private let myPageViewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "mypage"), for: .normal)
        
        return button
    }()
}

// MARK: - Lifecycle
extension TabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainView = MainViewController()
        let addView = AddViewController()
        let myPageView = MyPageViewController()
        
        self.viewControllers = [mainView, addView, myPageView]
        self.tabBarItems = [mainViewButton, addViewButton, myPageViewButton]
        tabBarItems
            .forEach { $0.addTarget(self, action: #selector(tabBarButtonTapped), for: .touchUpInside) }
        for (index, item) in tabBarItems.enumerated() {
            item.tag = index
        }
        
        setupUI()
        attchView(selectedIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - Method
extension TabBarController {
    
    @objc private func tabBarButtonTapped(_ sender: UIButton) {
        guard self.selectedIndex != sender.tag else { return }
        
        removeView(selectedIndex)
        attchView(sender.tag)
        
        self.selectedIndex = sender.tag
    }
    
    private func attchView(_ index: Int) {
        let viewController = viewControllers[index]
        viewController.view.frame = view.frame
        viewController.didMove(toParent: self)
        
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        self.view.bringSubviewToFront(tabBar)
    }
    
    private func removeView(_ index: Int) {
        let viewController = viewControllers[index]
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(tabBar)
        tabBar.addSubview(mainViewButton)
        tabBar.addSubview(addViewButton)
        tabBar.addSubview(myPageViewButton)
        
        tabBar.snp.makeConstraints {
            $0.height.height.equalTo(84)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        
        mainViewButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        addViewButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        myPageViewButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
