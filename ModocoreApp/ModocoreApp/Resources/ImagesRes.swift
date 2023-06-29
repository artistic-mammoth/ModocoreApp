//
//  UIImage+ext.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 29.06.2023.
//

import UIKit

extension UIImage {
    static let pauseIcon: UIImage = {
        guard let icon = UIImage(systemName: "pause.fill") else {
            return UIImage()
        }
       return icon
    }()
    
    static let playIcon: UIImage = {
        guard let icon = UIImage(systemName: "play.fill") else {
            return UIImage()
        }
       return icon
    }()
}
