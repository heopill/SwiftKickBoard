//
//  TabBarButton.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/30/25.
//

import UIKit

class TabBarButton: UIButton {
    
    var buttonIsSelected: Bool = false
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        
        self.setImage(image, for: .normal)
        self.tintColor = .white
    }
    
    private func changeImage(_ image: UIImage?) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
