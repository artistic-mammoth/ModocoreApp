//
//  ExampleData.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 26.07.2023.
//

// TODO: remove after testing
final class ExampleData {
    private let sessionEXAMPLE = [
        SessionSetup(session: [
            IntervalParameters(type: .focus, seconds: 2),
            IntervalParameters(type: .rest, seconds: 2),
            IntervalParameters(type: .focus, seconds: 1),
            IntervalParameters(type: .rest, seconds: 1),
        ]),
        SessionSetup(session: [
            IntervalParameters(type: .focus, seconds: 7),
        ]),
        SessionSetup(session: [
            IntervalParameters(type: .focus, seconds: 5),
            IntervalParameters(type: .focus, seconds: 3),
            IntervalParameters(type: .rest, seconds: 4),
        ]),
        SessionSetup(session: [
            IntervalParameters(type: .focus, seconds: 7),
            IntervalParameters(type: .rest, seconds: 5),
        ]),
    ]
    
    func getRandomSession() -> SessionSetup {
        sessionEXAMPLE[Int.random(in: 0..<sessionEXAMPLE.count)]
    }
}
