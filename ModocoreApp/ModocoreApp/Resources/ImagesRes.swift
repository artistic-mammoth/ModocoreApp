//
//  UIImage+ext.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 29.06.2023.
//

import UIKit

extension UIImage {
    static let playIcon: UIImage = {
        guard let icon = UIImage(systemName: "play.fill") else {
            return UIImage()
        }
       return icon
    }()
    
    static let circleIndicator: UIImage = {
        guard let icon = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)) else {
            return UIImage()
        }
       return icon
    }()
    
    static let circleFillIndicator: UIImage = {
        guard let icon = UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)) else {
            return UIImage()
        }
       return icon
    }()
}
