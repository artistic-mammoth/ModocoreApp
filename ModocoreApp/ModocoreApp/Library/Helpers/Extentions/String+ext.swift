//
//  String+ext.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 27.06.2023.
//

import Foundation

extension String {
    static func secondsToString(_ seconds: Int) -> String {
        let m = Int(seconds / 60)
        let s = Int(seconds % 60)
        let sString = m < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(sString)"
    }
}
