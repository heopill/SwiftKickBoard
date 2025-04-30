//
//  TabBarButton.swift
//  SwiftKickBoard
//
//  Created by 최규현 on 4/30/25.
//

import UIKit

class TabBarButton: UIButton {
    
    private var defaultImage: UIImage?
    private var selectedImage: UIImage?
    var buttonIsSelected: Bool = false {
        didSet {
            if buttonIsSelected {
                setTitleFont(Nanum.bold(14))
                setImage(selectedImage)
            } else {
                setTitleFont(Nanum.light(12))
                setImage(defaultImage)
            }
        }
    }
    
    init(title: String, defaultImage: UIImage?, selectedImage: UIImage?) {
        super.init(frame: .zero)
        
        self.defaultImage = defaultImage
        self.selectedImage = selectedImage
        
        var config = UIButton.Configuration.plain()
        config.image = defaultImage
        config.imagePadding = 4
        config.imagePlacement = .top
        
        var attributeString = AttributedString.init(title)
        attributeString.font = Nanum.light(12)
        config.attributedTitle = attributeString
        
        self.configuration = config
        self.tintColor = .white
    }
    
    private func setTitleFont(_ font: UIFont?) {
        self.configuration?.attributedTitle?.font = font
    }
    
    private func setImage(_ image: UIImage?) {
        self.configuration?.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
