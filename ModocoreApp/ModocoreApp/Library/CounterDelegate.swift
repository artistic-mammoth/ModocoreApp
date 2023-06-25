//
//  CounterDelegate.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 24.06.2023.
//

import Foundation

protocol CounterDelegate: AnyObject {
    func updateTime(with timeInSec: Int)
    func startTimer(with timeInSec: Int)
    func stopTimer()
}
