//
//  MenuViewController.swift
//  concentration
//
//  Created by 1 on 29.01.2023.
//

import SpriteKit

struct IASceneType {
    let scene: SKScene.Type
    let label: String
}

class MenuViewController: UIViewController {
    
    let games: [IASceneType] = [
        .init(scene: AppleGameScene.self, label: "Apple Scene"),
        .init(scene: FloorsScene.self, label: "Floors Scene"),
        .init(scene: BilliardScene.self, label: "Billiard Scene"),
        .init(scene: TriangleScene.self, label: "Triangle Scene"),
        .init(scene: SpinningBoxAndBalls.self, label: "Spinning Box Scene")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stack = UIStackView()
        stack.alignment = . center
        stack.axis = .vertical
        stack.spacing = 8
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        let settingsButton = IAButton(type: .system, primaryAction: UIAction(title: "Settings") { _ in
                    let vc = SettingsVC()
                    self.navigationController?.pushViewController(vc, animated: true)
                })
        
        for game in games {
            let button = IAButton(type: .system, primaryAction: UIAction(title: "Button Title", handler: { _ in
                self.presentGameVC(sceneType: game.scene)
            }))
            button.setTitle("\(game.label)", for: .normal)
            stack.addArrangedSubview(button)
        }
        stack.addArrangedSubview(settingsButton)
    }
    
    func presentGameVC(sceneType: SKScene.Type) {
        let vc = GameViewController(sceneType: sceneType)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
