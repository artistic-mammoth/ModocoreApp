//
//  SoundRes.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 18.09.2023.
//

import Foundation

enum SoundResources {
    static let pianoNotificationUrl: URL? = {
        guard let url = Bundle.main.url(forResource: "piano-notification-5b", withExtension: "mp3") else { return nil }
        return url
    }()
}
