//
//  MenuViewController.swift
//  concentration
//
//  Created by 1 on 29.01.2023.
//

import SpriteKit

struct IASceneType {
    let scene: SKScene
    let label: String
}

class MenuViewController: UIViewController {
    
    let games: [IASceneType] = [
        .init(scene: AppleGameScene(), label: "Apple Scene"),
        .init(scene: BlankScene(), label: "Blank Scene"),
        .init(scene: TriangleScene(), label: "Triangle Scene")
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
        
        for game in games {
            let button = IAButton(type: .system, primaryAction: UIAction(title: "Button Title", handler: { _ in
                self.presentGameVC(scene: game.scene)
            }))
            button.setTitle("\(game.label)", for: .normal)
            stack.addArrangedSubview(button)
        }
    }
    
    func presentGameVC(scene: SKScene) {
        let vc = GameViewController()
        vc.scene = scene
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
