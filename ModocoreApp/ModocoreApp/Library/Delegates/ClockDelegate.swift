//
//  ClockDelegate.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 24.06.2023.
//

protocol ClockDelegate: AnyObject {
    func runClock(with setup: SessionSetup)
    func updateClockTime(_ seconds: Int)
    func updateClock(with param: IntervalParameters)
    func stopClock()
}
