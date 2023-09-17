//
//  Lifecycleable.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 18.09.2023.
//

protocol Lifecycleable: AnyObject {
    func appEnterBackground()
    func appEnterForeground()
}
