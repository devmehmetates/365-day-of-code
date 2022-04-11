//
//  GameScene.swift
//  Day66-Challenge
//
//  Created by Mehmet Ateş on 6.03.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    let backgrounds = ["wood", "bluewood", "greenwood"]
    let enemyCreatePos = [-100: [128, 640], 1200: [384]]
    let posibility = ["friend", "duck", "duck", "duck", "duck", "friend", "duck", "duck", "duck", "duck", "friend"]
    
    var gameTimer: Timer?
    var endTimer: Timer?
    var timeLabel: SKLabelNode!
    var endTime = 300 {
        didSet{
            timeLabel.text = "\(endTime) second"
        }
    }
    var timeInver = 1.0
    var duckSpeed = 500
    
    var duckCount = 0 {
        didSet{
            if duckCount == 300{
                duckSpeed = 1500
                setGameTime(time: 0.1)
            }else if duckCount == 200{
                duckSpeed = 1000
                setGameTime(time: 0.2)
            }else if duckCount == 100{
                duckSpeed = 750
                setGameTime(time: 0.3)
            }else if duckCount == 50{
                duckSpeed = 600
                setGameTime(time: 0.2)
            }
        }
    }
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var bulletLabel: SKLabelNode!
    var bullet = 5 {
        didSet {
            bulletLabel.text = "Bullet: \(bullet)"
        }
    }
    
    var gameOver: SKLabelNode?
    var resetGame: SKLabelNode?
    

    
    override func didMove(to view: SKView) {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        bulletLabel = SKLabelNode(fontNamed: "Chalkduster")
        bulletLabel.text = "Bullet: 5"
        bulletLabel.horizontalAlignmentMode = .right
        bulletLabel.position = CGPoint(x: 512 + (self.bulletLabel.frame.size.width / 2), y: 700)
        addChild(bulletLabel)
        
        
        
        timeLabel = SKLabelNode(fontNamed: "Chalkduster")
        timeLabel.text = "300 second"
        timeLabel.horizontalAlignmentMode = .right
        timeLabel.position = CGPoint(x: 230, y: 700)
        addChild(timeLabel)
        
        for (index,backgroundImage) in backgrounds.enumerated() {
            let background = SKSpriteNode(imageNamed: backgroundImage)
            background.size = CGSize(width: 1024, height: 256)
            background.position = CGPoint(x: 512, y: ((index + 1) * 256) - 128)
            background.zPosition = -1
            addChild(background)
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: timeInver, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
        endTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(endGameCount), userInfo: nil, repeats: true)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{ return }
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        
        if let gameOver = gameOver {
            if let resetGame = resetGame {
                if objects.contains(gameOver) || objects.contains(resetGame){
                    timeInver = 1.0
                    duckSpeed = 500
                    duckCount = 0
                    score = 0
                    bullet = 6
                    endTime = 300
                    gameTimer = Timer.scheduledTimer(timeInterval: timeInver, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
                    endTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(endGameCount), userInfo: nil, repeats: true)
                    gameOver.removeFromParent()
                    resetGame.removeFromParent()
                }
            }
        }
        
        if endTime != 0{
            if objects.contains(bulletLabel){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if self.bullet > 0{
                        self.bullet += 5 - self.bullet
                    }else{
                        self.bullet += 5
                    }
                    
                }
            }else{
                if self.bullet > 0{
                    bullet -= 1
                    if !objects.isEmpty{
                        for object in objects {
                            if object.name == "friend"{
                                score -= 25
                                object.removeFromParent()
                            }else if object.name == "duck"{
                                score += 5
                                object.removeFromParent()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setGameTime(time: CGFloat){
        self.gameTimer?.invalidate()
        self.timeInver -= time
        self.gameTimer = Timer.scheduledTimer(timeInterval: timeInver, target: self, selector: #selector(createTarget), userInfo: nil, repeats: true)
    }
    
    @objc func endGameCount(){
        if self.endTime <= 0{
            self.gameTimer?.invalidate()
            self.endTimer?.invalidate()
            self.gameOver = SKLabelNode(fontNamed: "Chalkduster")
            gameOver!.text = "Game Over"
            gameOver!.horizontalAlignmentMode = .right
            gameOver!.position = CGPoint(x: 512 + (self.gameOver!.frame.size.width / 2), y: 368)
            addChild(gameOver!)
            
            self.resetGame = SKLabelNode(fontNamed: "Chalkduster")
            resetGame!.text = "Reset Game"
            resetGame!.horizontalAlignmentMode = .right
            resetGame!.position = CGPoint(x: 512 + (self.gameOver!.frame.size.width / 2), y: 300)
            addChild(resetGame!)
        }else{
            self.endTime -= 1
        }
    }
    
    @objc func createTarget() {
        guard let pos = enemyCreatePos.randomElement() else { return }
        guard let posY = pos.value.randomElement() else { return }
        guard let target = posibility.randomElement() else { return }
        duckCount += 1
        
        let sprite = SKSpriteNode(imageNamed: target)
        sprite.position = CGPoint(x: pos.key, y: posY)
        sprite.name = target
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        if pos.key == -100{
            sprite.physicsBody?.velocity = CGVector(dx: self.duckSpeed, dy: 0)
        }else{
            sprite.xScale = -1
            sprite.physicsBody?.velocity = CGVector(dx: -self.duckSpeed, dy: 0)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x > 1300 || node.position.x < -150{
                node.removeFromParent()
            }
            
            if endTime == 0 && (node.name == "friend" || node.name == "duck") {
                node.removeFromParent()
            }
        }
    }
    
    
}


