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
    private var tabBarItems: [TabBarButton] = []
    private var viewControllers: [UIViewController] = []
    
    private let tabBar: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 42
        
        return view
    }()
    
    private let mainViewButton: TabBarButton = {
        let button = TabBarButton(image: UIImage(named: "map"))
        
        return button
    }()
    
    private let addViewButton: TabBarButton = {
        let button = TabBarButton(image: UIImage(named: "add"))
        
        return button
    }()
    
    private let myPageViewButton: TabBarButton = {
        let button = TabBarButton(image: UIImage(named: "mypage"))
        
        return button
    }()
}

// MARK: - Lifecycle
extension TabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainView = UINavigationController(rootViewController: MainViewController())
        let addView = UINavigationController(rootViewController: AddViewController())
        let myPageView = UINavigationController(rootViewController: MyPageViewController())
        
        self.viewControllers = [mainView, addView, myPageView]
        self.tabBarItems = [mainViewButton, addViewButton, myPageViewButton]
        tabBarItems
            .forEach { $0.addTarget(self, action: #selector(tabBarButtonTapped), for: .touchUpInside) }
        for (index, item) in tabBarItems.enumerated() {
            item.tag = index
        }
        
        setupUI()
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
    }
    
    private func attchView(_ index: Int) {
        tabBarItems[index].buttonIsSelected = true
        
        let viewController = viewControllers[index]
        viewController.view.frame = view.frame
        viewController.didMove(toParent: self)
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        self.view.bringSubviewToFront(tabBar)
    }
    
    private func removeView(_ index: Int) {
        tabBarItems[index].buttonIsSelected = false
        
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
