//
//  String+ext.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 27.06.2023.
//

import Foundation

extension String {
    static func secondsToString(_ seconds: Int) -> String {
        [Int(seconds / 60), Int(seconds % 60)].compactMap {
            String(format: "%02d", $0)
        }.joined(separator: ":")
    }
}


