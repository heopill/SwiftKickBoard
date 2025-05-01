//
//  CustomTabBarButton.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/30/25.
//

import UIKit

class CustomTabBarButton: UIButton {
    
    var defaultImage: UIImage?
    var selectedImage: UIImage?
    var buttonIsSelected: Bool = false {
        didSet {
            if buttonIsSelected {
                didButtonTapped(selectedImage)
            } else {
                didButtonTapped(defaultImage)
            }
        }
    }
    
    init(defaultImage: UIImage?, selectedImage: UIImage?) {
        super.init(frame: .zero)
        
        self.defaultImage = defaultImage
        self.selectedImage = selectedImage
        
        self.setImage(defaultImage, for: .normal)
    }
    
    func didButtonTapped(_ image: UIImage?) {
        self.setImage(image, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
