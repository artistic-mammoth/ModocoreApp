//
//  TimerAssembly.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 08.09.2023.
//

import UIKit

final class TimerAssembly {
    static func build() -> UIViewController {
        let viewController = TimerViewController()
        let counterService = CounterService()
        let presenter = TimerPresenter(view: viewController, counterService: counterService)
        counterService.delegate = presenter
        viewController.presenter = presenter
        
        return viewController
    }
}
