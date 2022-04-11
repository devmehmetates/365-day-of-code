//
//  GameScene.swift
//  Day85-87
//
//  Created by Mehmet Ateş on 26.03.2022.
//

import SpriteKit
import CoreMotion

enum CollisionTypes: UInt32{
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case teleport = 16
    case finish = 32
}

class GameScene: SKScene, SKPhysicsContactDelegate{
    var player: SKSpriteNode!
    var levelCount: Int = 1
    var lastTouchPosition: CGPoint?
    var motionManager: CMMotionManager!
    var isGameOver = false
    var teleportExitPoint = CGPoint(x: 0, y: 0)
    
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        setBackgroundAndScore()
        loadLevel(level: levelCount)
        createPlayer()
        
        physicsWorld.gravity = .zero
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        physicsWorld.contactDelegate = self
        
    }
    
    func loadLevel(level: Int){
        guard let levelURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") else {
            fatalError("Could not found level1.txt file")
        }
        guard let levelString = try? String(contentsOf: levelURL) else {
            fatalError("Coult not parse level1.txt file")
        }
            
        let lines = levelString.components(separatedBy: "\n")
        
        for (row, line) in lines.reversed().enumerated(){
            for (column, letter) in line.enumerated(){
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                
                if letter == "x"{
                    createGameObject(name: "block", position: position, type: CollisionTypes.wall, isBlock: true)
                }else if letter == "v"{
                    createGameObject(name: "vortex", position: position, type: CollisionTypes.vortex) { node in
                        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
                    }
                }else if letter == "t"{
                    createGameObject(name: "teleport", position: position, type: CollisionTypes.teleport)
                }
                else if letter == "e"{
                    self.teleportExitPoint = position
                    createGameObject(name: "teleport-exit", position: position, type: CollisionTypes.teleport)
                }else if letter == "s"{
                    createGameObject(name: "star", position: position, type: CollisionTypes.star)
                }else if letter == "f"{
                    createGameObject(name: "finish", position: position, type: CollisionTypes.finish)
                }else if letter == " "{
                    // Do nothing
                }else{
                    fatalError("Unknowed map letter \(letter)")
                }
            }
        }
    }
    
    func createGameObject(name: String, position: CGPoint, type: CollisionTypes, action: (_ node: SKSpriteNode) -> Void = {node in }, isBlock: Bool = false){
        let node = SKSpriteNode(imageNamed: name)
        node.name = name
        action(node)
        if !isBlock{
            node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        }else{
            node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        }
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = type.rawValue
        if !isBlock{
            node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        }
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return }

        
        #if targetEnvironment(simulator)
        if let currentTouch = lastTouchPosition {
            let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        #endif
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerCollided(with: nodeB)
        } else if nodeB == player {
            playerCollided(with: nodeA)
        }
    }
    
    func playerCollided(with node: SKNode) {
        if node.name == "vortex" {
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            
            player.run(sequence) { [weak self] in
                self?.createPlayer()
                self?.isGameOver = false
            }
        }else if node.name == "teleport"{
            player.physicsBody?.isDynamic = false
            isGameOver = true
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            player.run(sequence) { [weak self] in
                self?.createPlayer()
                self?.player.position = self!.teleportExitPoint
                self?.isGameOver = false
            }
            
            
        }else if node.name == "star" {
            node.removeFromParent()
            score += 1
        } else if node.name == "finish" {
            removeAllChildren()
            setBackgroundAndScore()
            createPlayer()
            levelCount += 1
            loadLevel(level: levelCount)
            physicsWorld.gravity = .zero
        }
    }
    
    func setBackgroundAndScore(){
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
    }
}
