//
//  SpinningBoxScene.swift
//  concentration
//
//  Created by Olha Dzhyhirei on 2/5/23.
//
import SpriteKit

class SpinningBoxAndBalls: SKScene {
    
    var ballQuantity = 16
    
    enum GameState { case startGame, playing }
    var gameState = GameState.startGame
    var box: SKShapeNode!
    
    override func didMove(to view: SKView) {
        self.anchorPoint = .init(x: 0, y: 0)
        self.scene?.backgroundColor = .link
        setupStartLabel()
        createteBox()
        fillTheBox()
    }
    
    // MARK:  game state: startGame
    
    func setupStartLabel() {
        let startLabel = SKLabelNode()
        startLabel.name = "start label"
        startLabel.fontColor = .black
        startLabel.fontSize = 26
        startLabel.text = "Tap anywhere to start"
        startLabel.fontName = "AvenirNext-Bold"
        startLabel.zPosition = 2
        startLabel.position = .init(x: self.frame.midX, y: self.frame.maxY * 0.8)
        let action = SKAction.sequence([.scale(by: 1.25, duration: 1), .scale(by: 0.8, duration: 1)])
        startLabel.run(.repeatForever(action))
        self.addChild(startLabel)
        
    }
    
    // MARK: game state: setupPlaying
    
    func createBall(ofRadius radius: CGFloat) -> SKSpriteNode {
        let ball = SKSpriteNode(texture: .init(imageNamed: "ball_04"))
        ball.size = .init(width: radius * 2, height: radius * 2)
        ball.physicsBody = .init(circleOfRadius: radius)
        ball.physicsBody?.isDynamic = false
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.restitution = 0.3
        ball.physicsBody?.friction = 0.05
        ball.name = "ball"
        return ball
    }
    
    func createteBox(){
        let side = frame.width < frame.height ? frame.width / sqrt(2) : frame.height / sqrt(2)
        box = SKShapeNode(rectOf: .init(width: side, height: side))
        box.fillColor = SKColor.white
        box.lineWidth = 5
        box.strokeColor = SKColor.red
        box.physicsBody = .init(edgeLoopFrom: box.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)))
        box.position = .init(x: frame.midX, y: frame.midY)
        self.addChild(box)
        box.run(.rotate(byAngle: .pi * 0.25, duration: 0))
    }
    
    func fillTheBox() {
        var count = ballQuantity
        let matrixSize = Int((sqrt(Double(ballQuantity))).rounded(.up))
        let matrixSingleBoxSize = box.frame.width / CGFloat(matrixSize)
        let offset = matrixSingleBoxSize / 2 * sqrt(2)
        let offsetRotation = box.frame.width * sqrt(2) / 2 - (box.frame.width / 2) - offset
        let ball = createBall(ofRadius: matrixSingleBoxSize * 0.40)
        print(matrixSingleBoxSize)
        for i in 0..<matrixSize {
            for j in 0..<matrixSize {
                if count > 0 {
                    count -= 1
                    let ballCopy = ball.copy() as! SKSpriteNode
                    self.addChild(ballCopy)
                    ballCopy.position = .init(x: box.frame.midX + offset * CGFloat(j) - offset * CGFloat(i) ,
                                              y: box.frame.maxY + offsetRotation - offset * CGFloat(i) - offset * CGFloat(j))
                    ballCopy.run(.wait(forDuration: 0.4))
                }
            }
        }
    }
    
    func startRotating() {
        self.children.forEach{ node in
            if node.name == "ball" {
                node.physicsBody?.isDynamic = true
                node.physicsBody?.affectedByGravity = true
            }
        }
        let action = SKAction.rotate(byAngle: -.pi, duration: 1)
        box.run(.repeatForever(action))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState {
        case .startGame:
            self.childNode(withName: "start label")?.removeFromParent()
            startRotating()
            gameState = .playing
        case .playing:
            let location = (touches.first!.location(in: self))
            let node = self.atPoint(location)
            if node.name == "ball" {
                node.removeFromParent()
                if  self.childNode(withName: "ball") == nil {
                    gameState = .startGame
                    box.removeFromParent()
                    setupStartLabel()
                    createteBox()
                    fillTheBox()
                    
                }
            }
        }
    }
}
