//
//  FloorsScene.swift
//  concentration
//
//  Created by 1 on 29.01.2023.
//

import SpriteKit
import GameKit

class FloorsScene: SKScene {
    
    var didStart = false
    
    let tapToStart = SKLabelNode(text: "TAP TO START")
    let cameraNode = SKCameraNode()
    var floors = [SKSpriteNode]()
    var balls = [SKShapeNode]()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .yellow
        
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.camera = cameraNode
        addChild(cameraNode)
                
        setElements()
        setWalls()
        setFloors()
        
        tapToStart.fontSize = 48
        tapToStart.fontColor = .purple
        self.addChild(tapToStart)
        tapToStart.run(.repeatForever(.sequence([
            .scale(to: 1.2, duration: 0.75),
            .scale(to: 1.0, duration: 0.75),
        ])))
    }
    
    func setElements() {
        let matrixSize = 4
        let matrixMargin: CGFloat = frame.width / 4
        let containerWidth = (self.size.width - matrixMargin * 2)
        let spasing: CGFloat = 2
        let allSpasingsWidth: CGFloat = CGFloat(matrixSize - 1) * spasing
        let allItemsWidth: CGFloat = containerWidth - allSpasingsWidth
        let itemWidth = allItemsWidth / CGFloat(matrixSize)
        
        let ball = SKShapeNode.init(circleOfRadius: itemWidth / 2)
        ball.fillColor = .red
        ball.physicsBody = SKPhysicsBody(circleOfRadius: itemWidth / 2)
        ball.physicsBody?.affectedByGravity = false
        ball.name = "ball"
        
        let offset = -frame.width / 2 + matrixMargin + 0.5 * itemWidth // its the same for x and y
        for i in 0..<matrixSize {
            for j in 0..<matrixSize {
                let copy = ball.copy() as! SKShapeNode
                copy.position = .init(
                    x: offset + CGFloat(i) * (itemWidth + spasing),
                    y: offset + CGFloat(j) * (itemWidth + spasing) + 200) // TODO: remove magic number
                addChild(copy)
                self.balls.append(copy)
            }
        }
    }
    
    func setWalls() {
        let leftWall = SKSpriteNode(texture: nil, color: .blue, size: .init(width: 64, height: 4000)) // TODO: calculate wall height
        leftWall.physicsBody = .init(rectangleOf: leftWall.size)
        leftWall.physicsBody?.isDynamic = false
        let rightWall = leftWall.copy() as! SKSpriteNode
        
        leftWall.position.x += (frame.width + leftWall.size.width) / 2
        rightWall.position.x -= (frame.width + leftWall.size.width) / 2
        
        self.addChild(leftWall)
        self.addChild(rightWall)
    }
    
    func setFloors() {
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
    }
    
    func start() {
        let sqns = SKAction.sequence([
            .wait(forDuration: 2),
            .run { self.removeUpperFloor() },
        ])
        self.run(.repeatForever(sqns))
        
        tapToStart.isHidden = true
        
        balls.forEach {
            $0.physicsBody?.affectedByGravity = true
        }
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
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let loc = touches.first!.location(in: self)
//        let prevLoc = touches.first!.previousLocation(in: self)
//
//        cameraNode.position.y -= loc.y - prevLoc.y
//        cameraNode.position.x -= loc.x - prevLoc.x
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard didStart else {
            didStart = true
            start()
            return
        }
        
        guard
            let location = touches.first?.location(in: self),
            let node = atPoint(location) as? SKShapeNode,
            node.name == "ball"
        else {
            return
        }
        
        node.removeFromParent()
    }
    
    

}
