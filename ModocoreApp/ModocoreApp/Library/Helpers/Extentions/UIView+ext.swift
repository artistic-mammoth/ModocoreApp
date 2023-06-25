//
//  UIView+ext.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 07.06.2023.
//

import UIKit

extension UIView {
    func addViews(_ views: [UIView]) {
        for v in views {
            addViews(v)
        }
    }
    
    func addViews(_ v: UIView) {
        self.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
    }
}
