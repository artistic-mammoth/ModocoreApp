//
//  CounterDelegate.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 24.06.2023.
//

import Foundation

protocol CounterDelegate: AnyObject {
    func startTimer(with param: TimerParameters)
    func updateTime(with timeInSec: Int)
    func switchState(with param: TimerParameters)
    func stopTimer()
}
