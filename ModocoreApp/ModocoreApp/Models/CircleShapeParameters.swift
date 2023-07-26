//
//  CircleShapeParameters.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 17.06.2023.
//

import UIKit

struct CircleShapeParameters {
    let powAmplitude: Int
    let powDynamics: Int
    let waveAmplitude: Int
    let diameter: Int
    let frequency: Int
    let speed: Double
    let opacity: Float
    let color: UIColor

    init(powAmplitude: Int, powDynamics: Int, waveAmplitude: Int, diameter: Int, frequency: Int, speed: Double, opacity: Float, color: UIColor) {
        self.powAmplitude = powAmplitude
        self.powDynamics = powDynamics
        self.waveAmplitude = waveAmplitude
        self.diameter = diameter
        self.frequency = frequency
        self.speed = speed
        self.opacity = opacity
        self.color = color
    }
}


/*
 // MARK: default testing
 let powAmplitude: Int = 9
 let powDynamics: Int = 10
 let waveAmplitude: Int = 20
 let diameter: Int = 300
 let frequency: Int = 3
 let speed: Double = 1 / 1000.0
 */
