# Day 86 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day85-87/Day85-87"> Project </a>

## Developing on SpriteKit

## Subjects

+ Tilt to move: CMMotionManager
+ Contacting but not colliding

## Tilt to move: CMMotionManager
Yes, we finished my level design. Now it's time to put a player and complete the game.
```swift
var player: SKSpriteNode!

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
```
The balls we used in our first game are suitable for this. After all, our game is played with a tilting motion. After doing this, let's call the method at the beginning of the game. Our ball will fall. Our game world still has a gravity. Let's solve this.

```swift
physicsWorld.gravity = .zero
```
That's it :) We don't have a real device? So we can't play the game? Of course, we're going to play with a little cheating. But that's not what we really need to learn.

```swift
var lastTouchPosition: CGPoint?

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
    if let currentTouch = lastTouchPosition {
        let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
        physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
    }
}
```
Here's our little trick. We can play with touch. Well, this is very independent of our game. What are we gonna do? Of course there is a solution to this too. First, let's add playing with the tilting.

```swift
import CoreMotion
var motionManager: CMMotionManager!

motionManager = CMMotionManager()
motionManager.startAccelerometerUpdates()


// main code block
if let accelerometerData = motionManager.accelerometerData {
    physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
}
```

```swift
override func update(_ currentTime: TimeInterval) {
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
```
A solution you see. If the simulator is used, it is necessary to tilt on the real device while working with touch. Isn't that exactly what we want? And also with Coremotion it's really easy.

## Contacting but not colliding 
Yes, we have a player now. Let's interact now.
```swift
var scoreLabel: SKLabelNode!

var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}

scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
scoreLabel.text = "Score: 0"
scoreLabel.horizontalAlignmentMode = .left
scoreLabel.position = CGPoint(x: 16, y: 16)
scoreLabel.zPosition = 2
addChild(scoreLabel)
```
Let's prepare our leaderboard first.
```swift
didMove .. SKPhysicsContactDelegate {

physicsWorld.contactDelegate = self
```

```swift
func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }

    if nodeA == player {
        playerCollided(with: nodeB)
    } else if nodeB == player {
        playerCollided(with: nodeA)
    }
}
```
We remember how we did our collisions, don't we?

```swift
var isGameOver = false

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
```
Do not worry that the code is long. Only the first line added. If the game is over stop updating.

```swift
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
    } else if node.name == "star" {
        node.removeFromParent()
        score += 1
    } else if node.name == "finish" {
        // next level?
    }
}
```
Let's write down the method we use for collisions. Do you understand what we did? Delete by shrinking the user when the vortex is hit. Then recreate the player as it was originally. Did you notice anything while doing this? A code that stops the update function so that our user can't escape the vortex :)

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

