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
    
    var scene: SKScene? // TODO: replace let and pass it with init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = SKView(frame: self.view.frame)
        skView.showsPhysics = true
        super.view = skView
        
        print(view.frame)
        scene?.scaleMode = .resizeFill
        skView.presentScene(scene)

        if nil == scene {
            print("found nil in scene!")
        }
    }
}
