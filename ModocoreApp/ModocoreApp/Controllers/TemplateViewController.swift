//
//  TemplateViewController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 03.05.2023.
//

import UIKit

final class TemplateViewController: UIViewController {
    
    private let label: UILabel = {
       let label = UILabel()
        label.font = UIFont.blackInter(size: 28)
        label.text = "Coming soon..."
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        layoutView()
        
    }
    
    func layoutView() {
        view.addViews([label])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.heightAnchor.constraint(equalToConstant: 200),
            label.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
