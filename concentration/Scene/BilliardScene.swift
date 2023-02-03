//
//  BilliardScene.swift
//  concentration
//
//  Created by Roman Yarmoliuk on 30.01.2023.
//

import SpriteKit

class BilliardScene: SKScene {
    
    
    var startPoint = CGPoint()
    var whiteBall = SKShapeNode()
    let startLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .init(red: 21 / 255, green: 88 / 255, blue: 67 / 255, alpha: 1)
        self.anchorPoint = .init(x: 0.5, y: 0.5)
       
        startLabel.text = "swipe to start"
        startLabel.fontSize = 40
        
        startLabel.position.x = self.position.x
        startLabel.position.y = -self.frame.height / 4

        startLabel.zPosition = 11
        addChild(startLabel)
        
        let matrixSize = 6
    
        let matrixMargin: CGFloat = 80

                
        let containerWidth = size.width - (matrixMargin * 2)
      
        let width = containerWidth / CGFloat(matrixSize)

        let card = SKShapeNode.init(circleOfRadius: width / 2)

        card.name = "card"
        
        card.physicsBody = .init(circleOfRadius: width / 2)
        card.physicsBody?.restitution = 0.8
        
        let xOffset = -frame.width / 2 + matrixMargin + 0.5 * width
        let yOffset: CGFloat = -50
        for i in 0..<matrixSize {
            let y = yOffset + CGFloat(i) * (width)
            for j in 0..<matrixSize {
                
                let x = xOffset + CGFloat(j) * (width)
                let copy = card.copy() as! SKShapeNode
                copy.position = CGPoint(x: x, y: y)
                copy.fillColor = .black
                print(copy.name!)
                addChild(copy)
            }
        }
        
        whiteBall = SKShapeNode.init(circleOfRadius: width / 2)
        
        whiteBall.fillColor = .white
        whiteBall.position = CGPoint(x: frame.midX, y: frame.minY)
        
        whiteBall.physicsBody = .init(circleOfRadius: width / 2)
        whiteBall.physicsBody?.mass = 20
        whiteBall.physicsBody?.restitution = 0.8
        
        addChild(whiteBall)
        
        physicsWorld.gravity.dy = 0
    
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: .init(top: 0, left: 0, bottom: 0, right: 0)))
    }
    
    func applyRandomImpulse(to node: SKNode) {
        
        let arr = Array(7...9).map { $0 * 600 } + Array(-9...(-7)).map { $0 * 600 }
        
        let dx = arr.randomElement()!
        let dy = arr.randomElement()!
        
        node.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)
        
        startPoint = location
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
       
        let node = self.atPoint(location)
        if node.name == "card" {
            node.removeFromParent()
            applyRandomImpulse(to: whiteBall)
        }
        
        if !startLabel.isHidden {
            startLabel.isHidden = true

            let dy = (location.y - startPoint.y) * 50
            let dx = -(location.x - startPoint.x) * 50
            whiteBall.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))

        }
    }


}
