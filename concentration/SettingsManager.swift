//
//  SettingsManager.swift
//  concentration
//
//  Created by Roman Yarmoliuk on 20.02.2023.
//

import Foundation

class SettingsManager {
    
    private let vibrationKey = "vibration"
    private let soundKey = "sound"
    private let volumeKey = "volume"
    private let appearanceKey = "appearance"
    private let colorKey = "color"
    
    
    private init() {
        UserDefaults.standard.register(defaults: [
            vibrationKey : true,
            soundKey : true,
            volumeKey : 0.5,
            appearanceKey : 0,
            colorKey : 0
        ])
    }
    
    static let shared = SettingsManager()
    
    func getVibration() -> (Bool) {
        UserDefaults.standard.bool(forKey: vibrationKey)
    }
    
    func setVibration(value: Bool)  {
        UserDefaults.standard.set(value, forKey: vibrationKey)
    }
    
    func getSound() -> (Bool) {
        UserDefaults.standard.bool(forKey: soundKey)
    }
    
    func setSound(value: Bool)  {
        UserDefaults.standard.set(value, forKey: soundKey)
    }
    
    func getVolume() -> (Float) {
        UserDefaults.standard.float(forKey: volumeKey)
    }
    
    func setVolume(value: Float)  {
        UserDefaults.standard.set(value, forKey: volumeKey)
    }
    
    func getAppearance() -> (Int) {
        UserDefaults.standard.integer(forKey: appearanceKey)
    }
    
    func setAppearance(value: Int)  {
        UserDefaults.standard.set(value, forKey: appearanceKey)
    }
    
    func getColor() -> (Int) {
        UserDefaults.standard.integer(forKey: colorKey)
    }
    
    func setColor(value: Int)  {
        UserDefaults.standard.set(value, forKey: colorKey)
    }
}

