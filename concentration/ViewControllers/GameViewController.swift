//
//  GameViewController.swift
//  concentration
//
//  Created by 1 on 27.01.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    init(sceneType: SKScene.Type) {
        self.sceneType = sceneType
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let sceneType: SKScene.Type

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = SKView(frame: self.view.frame)
        skView.showsPhysics = true
        super.view = skView
        
        let scene = sceneType.init(size: .zero)
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
}
