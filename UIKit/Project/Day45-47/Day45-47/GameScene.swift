//
//  GameScene.swift
//  Day45-47
//
//  Created by Mehmet Ateş on 14.02.2022.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    var scoreLabel: SKLabelNode!
    var colors = ["Red","Cyan","Yellow","Blue","Grey","Purple"]
    
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    var ballLabel: SKLabelNode!
    
    var ballCount :Int = 5 {
        didSet {
            ballLabel.text = "Remaining Ball: \(ballCount)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(position: CGPoint(x: 0, y: 0))
        makeBouncer(position: CGPoint(x: 256, y: 0))
        makeBouncer(position: CGPoint(x: 512, y: 0))
        makeBouncer(position: CGPoint(x: 768, y: 0))
        makeBouncer(position: CGPoint(x: 1024, y: 0))
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        ballLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballLabel.text = "Remaining Ball: 5"
        ballLabel.horizontalAlignmentMode = .right
        ballLabel.position = CGPoint(x: 980, y: 650)
        addChild(ballLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        
        for _ in 0...10{
            let size = CGSize(width: Int.random(in: 16...128), height: 16)
            let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
            box.zRotation = CGFloat.random(in: 0...1)
            box.position = CGPoint(x: CGFloat.random(in: 100...900), y: CGFloat.random(in: 300...500))
            box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
            box.physicsBody?.isDynamic = false
            box.name = "pins"
            addChild(box)
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ballCount < 1 {
            print("Game over")
        }else{
            guard let touch = touches.first else{ return }
            let location = touch.location(in: self)
            
            let objects = nodes(at: location)
            
            if objects.contains(editLabel) {
                editingMode.toggle()
            } else {
                if editingMode {
                    let size = CGSize(width: Int.random(in: 16...128), height: 16)
                    let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                    box.zRotation = CGFloat.random(in: 0...3)
                    box.position = location
                    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                    box.physicsBody?.isDynamic = false
                    addChild(box)
                } else {
                    let ball = SKSpriteNode(imageNamed:  "ball" + colors[Int.random(in: 0...colors.count - 1)])
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
                    ball.physicsBody?.restitution = 0.5
                    ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                    ball.position = CGPoint(x: location.x, y: 700)
                    ball.name = "ball"
                    ballCount -= 1
                    addChild(ball)
                }
            }
        }
        
//        let box = SKSpriteNode(color: .red, size: CGSize(width: 64, height: 64))
//        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
//        box.position = location
//        addChild(box)
        
        
    }
    
    func makeBouncer(position : CGPoint){
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width/2)
        bouncer.physicsBody?.isDynamic = false
        bouncer.name = "bouncer" + String(Int.random(in: 0...100))
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        slotGlow.position = position
        
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
        
        addChild(slotBase)
        addChild(slotGlow)
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
            ballCount += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        }
    }
    
    
    func pinsBetween(pins: SKNode, ball: SKNode) {
        if pins.name == "pins" || pins.name == nil {
            destroy(ball: pins)
        }
    }
    
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
            pinsBetween(pins: nodeA, ball: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
            pinsBetween(pins: nodeA, ball: nodeB)
        }
        
    }

}
