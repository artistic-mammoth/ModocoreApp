//
//  UIView+addViews.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 06.09.2023.
//

import UIKit

extension UIView {
    func addViews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
