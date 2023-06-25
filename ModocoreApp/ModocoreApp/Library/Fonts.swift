//
//  Fonts.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 07.06.2023.
//

import UIKit

extension UIFont {
    static func boldInter(size: CGFloat) -> UIFont {
      guard let customFont = UIFont(name: "Inter-Bold", size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return customFont
    }
    
    static func blackInter(size: CGFloat) -> UIFont {
      guard let customFont = UIFont(name: "Inter-Black", size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return customFont
    }
    
    static func mediumInter(size: CGFloat) -> UIFont {
      guard let customFont = UIFont(name: "Inter-Medium", size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return customFont
    }
    
    static func lightInter(size: CGFloat) -> UIFont {
      guard let customFont = UIFont(name: "Inter-Light", size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return customFont
    }
    
    static func thinInter(size: CGFloat) -> UIFont {
      guard let customFont = UIFont(name: "Inter-Thin", size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return customFont
    }
    
    static func regularInter(size: CGFloat) -> UIFont {
      guard let customFont = UIFont(name: "Inter-Regular", size: size) else {
        return UIFont.systemFont(ofSize: size)
      }
      return customFont
    }

}
