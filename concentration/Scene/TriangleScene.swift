//
//  TriangleScene.swift
//  concentration
//
//  Created by Vlad Andrushok on 30.01.2023.
//

import SpriteKit

class TriangleScene: SKScene {
    
    let sizeBall: CGFloat = 30
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        
        let circul = SKTexture(imageNamed: "ball")
        let spriteСircul = SKSpriteNode(texture: circul, size: .init(width: sizeBall, height: sizeBall))
        spriteСircul.physicsBody = SKPhysicsBody(circleOfRadius: sizeBall / 2)
        spriteСircul.position = .init(x: 0, y: self.frame.maxY - 100)
        
        for _ in 0...50 {
            let copy = spriteСircul.copy() as! SKSpriteNode
            self.addChild(copy)
        }

        
        self.backgroundColor = .cyan
        
        let borderBody =  SKPhysicsBody (edgeLoopFrom: self.frame)
        borderBody.friction =  0
        self.physicsBody = borderBody
        
        
        addTriangle()
    }
    
    func setTriangle() -> SKSpriteNode {
        
        let triangleTexture = SKTexture(imageNamed: "triangle")
        let spriteTriangle = SKSpriteNode(texture: triangleTexture, size: .init(width: self.frame.width - (sizeBall * 2), height: 100))
        
        let offsetX = spriteTriangle.frame.size.width * spriteTriangle.anchorPoint.x
        let offsetY = spriteTriangle.frame.size.height * spriteTriangle.anchorPoint.y
        
        let path = CGMutablePath()
        let startPoint = CGPoint(x: -offsetX, y: -offsetY)
        path.move(to: startPoint)
        let secPoint = startPoint.applying(.init(translationX: spriteTriangle.frame.size.width / 2, y: spriteTriangle.frame.size.height))
        path.addLine(to: secPoint)
        let thrdPoint = secPoint.applying(.init(translationX: spriteTriangle.frame.size.width / 2, y: -spriteTriangle.frame.size.height))
        path.addLine(to: thrdPoint)
        path.closeSubpath()
        
        spriteTriangle.physicsBody = SKPhysicsBody(polygonFrom: path)
        
        spriteTriangle.position = CGPoint(x: 0, y: self.frame.minY - spriteTriangle.frame.height / 2)
        spriteTriangle.physicsBody?.affectedByGravity = false
        spriteTriangle.physicsBody?.isDynamic = false

        return spriteTriangle
    }
    
    func addTriangle() {
        
        let triangle = self.setTriangle()
        addChild(triangle)
        
        let sqns = SKAction.sequence([
            SKAction.moveTo(y: self.frame.maxY + triangle.frame.height, duration: 3),
            SKAction.run({
                triangle.position = CGPoint(x: 0, y: self.frame.minY - triangle.frame.height / 2)
            })
        ])

        let repeatMoveTriangle = SKAction.repeatForever(sqns)

        triangle.run(repeatMoveTriangle)
    }
}
