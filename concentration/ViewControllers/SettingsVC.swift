//
//  SettingsVC.swift
//  concentration
//
//  Created by Roman Yarmoliuk on 17.02.2023.
//

import UIKit

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


var models = [Section]()

class SettingsVC: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        
        table.register(SettingsTableViewCell.self,
                       forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.register(SwitchTableViewCell.self,
                       forCellReuseIdentifier: SwitchTableViewCell.identifier)
        table.register(SliderTableViewCell.self,
                       forCellReuseIdentifier: SliderTableViewCell.identifier)
        table.register(SegmentTableViewCell.self,
                       forCellReuseIdentifier: SegmentTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func configure() {
        
        let vibrationImage = UIImage(systemName: "iphone.radiowaves.left.and.right")!
        let soundImage = UIImage(systemName: "volume.1")!
        let volumeImage = UIImage(systemName: "volume.3")!
        let appearanceImage = UIImage(systemName: "circle.lefthalf.filled")!
        let colorImage = UIImage(systemName: "circle.hexagonpath")!
        let lockImage = UIImage(systemName: "lock")!
        let newspaperImage = UIImage(systemName: "newspaper")!
        
        let appearanceOptions = ["System", "Light", "Dark"]
        let colors = ["Black", "Red", "Yellow", "Green"]
                
        models.append(Section(title: "Vibration and Sound",options: [
            .switchCell(model: SettingsSwitchOption(title: "Vibration",
                                                    icon: vibrationImage,
                                                    iconBackgroundColor: .systemGreen,
                                                    isOn: true) { isOn in
                                                        isOn ? print("Vibration On") : print("Vibration off")
                                                    }),
            .switchCell(model: SettingsSwitchOption(title: "Sound",
                                                    icon: soundImage,
                                                    iconBackgroundColor: .systemIndigo,
                                                    isOn: true) { isOn in
                                                        isOn ? print("Sound On") : print("Sound off")
                                                    }),
            .sliderCell(model: SettingsSliderOption(title: "Volume",
                                                    icon: volumeImage,
                                                    iconBackgroundColor: .systemBlue,
                                                    value: 0) { value in
                                                        print("Volume: \(value * 100)")
                                                    })
        ]))
        
        models.append(Section(title: "Appearance", options: [
            .segmentCell(model: SettingsSegmentOption(title: "Mode",
                                                      icon: appearanceImage,
                                                      iconBackgroundColor: .systemGray,
                                                      segments: appearanceOptions) { [weak self] selectedIndex in
                                                          switch selectedIndex {
                                                          case 0:
                                                              self?.tableView.window?.overrideUserInterfaceStyle = .unspecified
                                                          case 1:
                                                              self?.tableView.window?.overrideUserInterfaceStyle = .light
                                                          default:
                                                              self?.tableView.window?.overrideUserInterfaceStyle = .dark
                                                          }
                                                      }),
            .segmentCell(model: SettingsSegmentOption(title: "Color",
                                                      icon: colorImage,
                                                      iconBackgroundColor: .systemRed,
                                                      segments: colors) { selectedIndex in
                                                          switch selectedIndex {
                                                          case 0:
                                                              print(colors[selectedIndex])
                                                          case 1:
                                                              print(colors[selectedIndex])
                                                          case 2:
                                                              print(colors[selectedIndex])
                                                          default:
                                                              print(colors[selectedIndex])
                                                          }
                                                      })
        ]))
        
        models.append(Section(title: "Privacy, Terms conditions", options: [
            .staticCell(model: SettingsOption (title: "Privacy",
                                               icon: lockImage,
                                               iconBackgroundColor: .systemPink) {
                                                   print("Static")
                                               }),
            .staticCell(model: SettingsOption (title: "Terms conditions",
                                               icon: newspaperImage,
                                               iconBackgroundColor: .systemPink) {
                                                   print("Static")
                                               })
        ]))
        
    }
    
    deinit {
        models = []
        print("Settings deinited")
    }
    
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        switch model.self {
        case .staticCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.identifier,
                for: indexPath
            ) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            cell.buttonHandler = {
                model.handler()
            }
            return cell
        case .switchCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            cell.switchHandler = { isOn in
                model.handler(isOn)
            }
            return cell
        case .sliderCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SliderTableViewCell.identifier,
                for: indexPath
            ) as? SliderTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            cell.sliderHandler = { value in
                model.handler(value)
            }
            return cell
        case .segmentCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SegmentTableViewCell.identifier,
                for: indexPath
            ) as? SegmentTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            cell.segmentHandler = { selectedIndex in
                model.handler(selectedIndex)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self {
        case .staticCell(model: let model):
            model.handler()
        case .switchCell:
            print("Switch cell")
        case .sliderCell:
            print("Slider cell")
        case .segmentCell:
            print("Segment cell")
        }
    }
}


