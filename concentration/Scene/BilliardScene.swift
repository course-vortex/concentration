//
//  BilliardScene.swift
//  concentration
//
//  Created by Roman Yarmoliuk on 30.01.2023.
//

import SpriteKit

class BilliardScene: SKScene {
    
    let matrixSize = 5
    let matrixMargin: CGFloat = 32
    let spacing: CGFloat = 4
    
    var startPoint = CGPoint()
    var whiteBall = SKShapeNode()
    
    override func didMove(to view: SKView) {
        
        self.removeAllChildren()
        
        self.anchorPoint = .init(x: 0.5, y: 0.5)
                
        let containerWidth = size.width - (CGFloat(matrixMargin) * 2 + spacing * CGFloat(matrixSize - 1))
      
        let width = containerWidth / CGFloat(matrixSize)

        let card = SKShapeNode.init(circleOfRadius: width / 2)
        
        card.physicsBody = .init(circleOfRadius: width / 2)
        card.physicsBody?.restitution = 0.8
        
        let xOffset = -frame.width / 2 + matrixMargin + 0.5 * width
        let yOffset: CGFloat = -50
        for i in 0..<matrixSize {
            let y = yOffset + CGFloat(i) * (width + spacing)
            for j in 0..<matrixSize {
                
                let x = xOffset + CGFloat(j) * (width + spacing)
                let copy = card.copy() as! SKShapeNode
                copy.position = CGPoint(x: x, y: y)
                copy.fillColor = .black
                
                addChild(copy)
            }
        }
        
        whiteBall = SKShapeNode.init(circleOfRadius: width / 2)
        
        whiteBall.fillColor = .white
        whiteBall.position = CGPoint(x: frame.midX, y: frame.minY)
        
        whiteBall.physicsBody = .init(circleOfRadius: width / 2)
        whiteBall.physicsBody?.mass = 20
        
        let sqns = SKAction.sequence([
            .run { self.applyRandomImpulse(to: self.whiteBall) },
            .wait(forDuration: 5)
        ])
        
        run(.repeatForever(sqns))
        
        addChild(whiteBall)
        
        physicsWorld.gravity.dy = 0
    
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: .init(top: 0, left: 0, bottom: 0, right: 0)))
    }
    
    func applyRandomImpulse(to node: SKNode) {
        
        let arr = Array(5...9).map { $0 * 300 } + Array(-9...(-5)).map { $0 * 300 }
        
        let dx = arr.randomElement()!
        let dy = arr.randomElement()!
        
        node.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: view)
        startPoint = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: view)
        let dy = (location.y - startPoint.y) * 50
        let dx = -(location.x - startPoint.x) * 50
        whiteBall.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
    }


}
