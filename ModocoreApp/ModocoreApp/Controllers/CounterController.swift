//
//  CounterController.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 24.06.2023.
//

import Foundation

class CounterController {
    var time = 0
    weak var timer: Timer?
    
    weak var delegate: CounterDelegate?
    
    func startCounter(with timeInSec: Int) {
        time = timeInSec
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        delegate?.startTimer(with: timeInSec)
    }
    
    @objc func timerAction() {
        if time >= 0 {
            delegate?.updateTime(with: time)
            time -= 1
        }
        else {
            delegate?.updateTime(with: 0)
            timer?.invalidate()
            delegate?.stopTimer()
            delegate = nil
        }
    }
}
