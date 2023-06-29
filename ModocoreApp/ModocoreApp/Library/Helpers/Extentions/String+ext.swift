//
//  String+ext.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 27.06.2023.
//

import Foundation

extension String {
    static func secondsToString(_ timeInSec: Int) -> String {
        let h = Int(timeInSec / 60)
        let m = Int(timeInSec % 60)
        let mString = m < 10 ? "0\(m)" : "\(m)"
        return "\(h):\(mString)"
    }
}
