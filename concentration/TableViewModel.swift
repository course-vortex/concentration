//
//  TableViewModel.swift
//  concentration
//
//  Created by Roman Yarmoliuk on 19.02.2023.
//

import Foundation

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
    case sliderCell(model: SettingsSliderOption)
    case segmentCell(model: SettingsSegmentOption)
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    var isOn: Bool
    let handler: ((Bool) -> Void)
}

struct SettingsSliderOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    var value: Float
    let handler: ((Float) -> Void)
}

struct SettingsSegmentOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    var segments: [String]
    let handler: ((Int) -> Void)
}
