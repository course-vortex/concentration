//
//  FloorsScene.swift
//  concentration
//
//  Created by 1 on 29.01.2023.
//

import SpriteKit

class FloorsScene: SKScene {
    
    let cameraNode = SKCameraNode()
    var floors = [SKSpriteNode]()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .yellow
        
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        
        self.camera = cameraNode
        addChild(cameraNode)
                
        setElements()
        
        let floorSize = CGSize(width: frame.width, height: 16)
        for i in 0...10 {
            let floor = SKSpriteNode(texture: nil, color: .blue, size: floorSize)
            let isOdd = i % 2 == 0
            floor.zRotation = isOdd ? 0.2 : -0.2
            floor.position.y -= frame.width * 0.245 * CGFloat(i)
            floor.physicsBody = .init(rectangleOf: floor.size)
            floor.physicsBody?.isDynamic = false
            self.addChild(floor)
            self.floors.append(floor)
        }
        
        let leftWall = SKSpriteNode(texture: nil, color: .blue, size: .init(width: 64, height: 4000)) // TODO: calculate wall height
        leftWall.physicsBody = .init(rectangleOf: leftWall.size)
        leftWall.physicsBody?.isDynamic = false
        let rightWall = leftWall.copy() as! SKSpriteNode
        
        leftWall.position.x += (frame.width + leftWall.size.width) / 2
        rightWall.position.x -= (frame.width + leftWall.size.width) / 2
        
        self.addChild(leftWall)
        self.addChild(rightWall)
        
        let sqns = SKAction.sequence([
            .run { self.removeUpperFloor() },
            .wait(forDuration: 2)
        ])
        self.run(.repeatForever(sqns))
    }
    
    func removeUpperFloor() {
        guard !floors.isEmpty else {
            print("no more floors!")
            return
        }
        
        let firstFloor = floors.removeFirst()
        firstFloor.removeFromParent()
        
        if let nextFloor = floors.first {
            cameraNode.run(.moveTo(y: nextFloor.position.y + 100, duration: 1))
        }
    }
    
    func setElements() {
        let matrixSize = 4
        let matrixMargin: CGFloat = 64
        let containerWidth = (self.size.width - matrixMargin * 2)
        let spasing: CGFloat = 8
        let allSpasingsWidth: CGFloat = CGFloat(matrixSize - 1) * spasing
        let allItemsWidth: CGFloat = containerWidth - allSpasingsWidth
        let itemWidth = allItemsWidth / CGFloat(matrixSize)
        
        let spinnyNode = SKShapeNode.init(circleOfRadius: itemWidth / 2)
        spinnyNode.fillColor = .red
        spinnyNode.physicsBody = SKPhysicsBody(circleOfRadius: itemWidth / 2)

        
        let offset = -frame.width / 2 + matrixMargin + 0.5 * itemWidth // its the same for x and y
        for i in 0..<matrixSize {
            for j in 0..<matrixSize {
                let copy = spinnyNode.copy() as! SKShapeNode
                copy.position = .init(
                    x: offset + CGFloat(i) * (itemWidth + spasing),
                    y: offset + CGFloat(j) * (itemWidth + spasing) + 400) // TODO: remove magic number
                addChild(copy)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let loc = touches.first!.location(in: self)
        let prevLoc = touches.first!.previousLocation(in: self)
        
        cameraNode.position.y -= loc.y - prevLoc.y
        cameraNode.position.x -= loc.x - prevLoc.x
    }
    
    

}
