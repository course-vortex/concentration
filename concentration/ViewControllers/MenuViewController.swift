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
        .init(scene: BlankScene.self, label: "Blank Scene"),
        .init(scene: FloorsScene.self, label: "Floors Scene")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stack = UIStackView()
        stack.alignment = . center
        stack.axis = .vertical
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        for game in games {
            let button = UIButton(type: .system, primaryAction: UIAction(title: "Button Title", handler: { _ in
                self.presentGameVC(sceneType: game.scene)
            }))
            button.setTitle("\(game.label)", for: .normal)
            stack.addArrangedSubview(button)
        }
    }
    
    func presentGameVC(sceneType: SKScene.Type) {
        let vc = GameViewController(sceneType: sceneType)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
