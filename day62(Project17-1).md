# Day 62 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day62-63/Day62-63"> Project </a>

## Developing on SpriteKit

## Subjects

+ Set-Up
+ Space: the final frontier
+ Bring on the enemies: linearDamping, angularDamping
+ Making contact: didBegin()

## Set-Up
The same template we created for your iPad special games.

## Space: the final frontier
```swift
var starfield: SKEmitterNode!
var player: SKSpriteNode!

var scoreLabel: SKLabelNode!
var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```
```swift
override func didMove(to view: SKView) {

    // Lets create a space
    backgroundColor = .black
    starfield = SKEmitterNode(fileNamed: "starfield")!
    starfield.position = CGPoint(x: 1024, y: 384)
    starfield.advanceSimulationTime(10)
    addChild(starfield)
    starfield.zPosition = -1

    // Where am I? Okay I'm Here 😎
    player = SKSpriteNode(imageNamed: "player")
    player.position = CGPoint(x: 100, y: 384)
    player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
    player.physicsBody?.contactTestBitMask = 1
    addChild(player)

    // This is a game. Quick, bring here a score board!
    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.position = CGPoint(x: 16, y: 16)
    scoreLabel.horizontalAlignmentMode = .left
    addChild(scoreLabel)

    // Let's begin the game
    score = 0
    physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    physicsWorld.contactDelegate = self
}
```
Imagine a space. You're thinking of stars and a pitch black sole. So what we need to do is, I think, very clear. Let's use our sks file given to us and create a space. SKEmitter gives us convenience for effect. Okay, we put the stars first, the space is ready. so where are we? It's time to call our tracking rocket.

## Bring on the enemies: linearDamping, angularDamping


Being a hero takes struggle. Bring the enemies.
```swift
let possibleEnemies = ["ball", "hammer", "tv"]
var isGameOver = false
var gameTimer: Timer?
```

Does whirling come hammers, balls, and televisions? Man, this space is a complete dump.
```swift
@objc func createEnemy() {
    guard let enemy = possibleEnemies.randomElement() else { return }

    let sprite = SKSpriteNode(imageNamed: enemy)
    sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
    addChild(sprite)

    sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
    sprite.physicsBody?.categoryBitMask = 1
    sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
    sprite.physicsBody?.angularVelocity = 5
    sprite.physicsBody?.linearDamping = 0
    sprite.physicsBody?.angularDamping = 0
}
```


How is traffic in space? Construct an enemy in 35 milliseconds. How much traffic there is!
```swift
gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
```

Let's not forget that we are in the game. If we still didn't crash, let's score!
```swift
override func update(_ currentTime: TimeInterval) {
    for node in children {
        if node.position.x < -300 {
            node.removeFromParent()
        }
    }

    if !isGameOver {
        score += 1
    }
}
```

##  Making contact: didBegin()
Yes, everything is fine, but we cannot play the game. Time to take control!

Our steering wheel. our finger. Well, let's not go too far. Don't you have to play the game by the rules?
```swift
    guard let touch = touches.first else { return }
    var location = touch.location(in: self)

    if location.y < 100 {
        location.y = 100
    } else if location.y > 668 {
        location.y = 668
    }

    player.position = location
```

Oops. Space travelers had an accident. Do you think it will be ok if we turn it off and on?
```swift
func didBegin(_ contact: SKPhysicsContact) {
    let explosion = SKEmitterNode(fileNamed: "explosion")!
    explosion.position = player.position
    addChild(explosion)

    player.removeFromParent()

    isGameOver = true
}
```

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

