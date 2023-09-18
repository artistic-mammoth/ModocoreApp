//
//  AudioService.swift
//  ModocoreApp
//
//  Created by Михайлов Александр on 18.09.2023.
//

import AVFoundation

protocol AudioServiceProtocol {
    func playAlertForEndOfState()
}

final class AudioService {
    // MARK: - Private properties
    private var player: AVAudioPlayer?
}

// MARK: - AudioServiceProtocol
extension AudioService: AudioServiceProtocol {
    func playAlertForEndOfState() {
        guard let url = SoundResources.pianoNotificationUrl else { return }
        do {
            player?.stop()
            
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.prepareToPlay()
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
