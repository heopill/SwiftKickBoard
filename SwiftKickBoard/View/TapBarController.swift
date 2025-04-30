//
//  TapBarController.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/30/25.
//

import UIKit
import SnapKit

class TapBarController: UIViewController {
    
    private var selectedIndex = 0
    private var tabBarItems: [TabBarButton] = []
    private var viewControllers: [UIViewController] = []
    
    private let tabBar: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private let homeButton: TabBarButton = {
        let button = TabBarButton(image: UIImage(named: "map"))
        
        return button
    }()
}

extension TapBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
