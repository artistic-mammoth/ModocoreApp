//
//  SessionSetup.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 24.06.2023.
//

typealias SessionSetup = [IntervalParameters]

extension SessionSetup {
    static func calculateWith(repeatTimes: Int, focusSeconds: Int, restSeconds: Int) -> SessionSetup {
        var intervalParameters: [IntervalParameters] = []
        for _ in 0..<repeatTimes {
            let focus = IntervalParameters(type: .focus, seconds: focusSeconds)
            let rest = IntervalParameters(type: .rest, seconds: restSeconds)
            intervalParameters.append(focus)
            intervalParameters.append(rest)
        }
        return intervalParameters
    }
}
