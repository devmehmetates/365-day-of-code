//
//  GameScene.swift
//  Day45-47
//
//  Created by Mehmet Ateş on 14.02.2022.
//

import SpriteKit

class GameScene: SKScene {

    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        makeBouncer(position: CGPoint(x: 0, y: 0))
        makeBouncer(position: CGPoint(x: 256, y: 0))
        makeBouncer(position: CGPoint(x: 512, y: 0))
        makeBouncer(position: CGPoint(x: 768, y: 0))
        makeBouncer(position: CGPoint(x: 1024, y: 0))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{ return }
        let location = touch.location(in: self)
        
//        let box = SKSpriteNode(color: .red, size: CGSize(width: 64, height: 64))
//        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
//        box.position = location
//        addChild(box)
        
        let ball = SKSpriteNode(imageNamed: "ballBlue")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.restitution = 0.5
        ball.position = location
        addChild(ball)
    }
    
    func makeBouncer(position : CGPoint){
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width/2)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }

}
