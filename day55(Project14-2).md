# Day 56 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day55-56/Day55-56"> Project </a>

## Developing on SpriteKit

## Subjects

+ Whack to win: SKAction sequences
+ Wrap up
+ Challenges

I will go directly to the challenges. Because I'm too tired to document the other parts.

## Challenges

## Record your own voice saying "Game over!" and have it play when the game ends.
```swift
let gameOver = SKSpriteNode(imageNamed: "gameOver")
gameOver.position = CGPoint(x: 512, y: 384)
gameOver.zPosition = 1
run(SKAction.playSoundFileNamed("gameover.m4a", waitForCompletion: false)) // Here
addChild(gameOver)
```

## When showing “Game Over” add an SKLabelNode showing their final score.

```swift
if numRounds >= 30 {
    for slot in slots {
        slot.hide()
    }

    let gameOver = SKSpriteNode(imageNamed: "gameOver")
    gameOver.position = CGPoint(x: 512, y: 384)
    gameOver.zPosition = 1
    run(SKAction.playSoundFileNamed("gameover.m4a", waitForCompletion: false))
    addChild(gameOver)

    /////////////////////// Here
    let overScore = SKLabelNode(fontNamed: "Chalkduster")
    overScore.text = "Your Score: \(score)"
    overScore.position = CGPoint(x: 512, y: 300)
    overScore.zPosition = 1
    addChild(overScore)
    //////////////////////

    return
}
```
## Use SKEmitterNode to create a smoke-like effect when penguins are hit, and a separate mud-like effect when they go into or come out of a hole.
We don't have the sks files so I found an sks from other projects and used it. So there is no difference. It only comes out when requested.

Hitting
```swift
whackSlot.hit()

if let booom = SKEmitterNode(fileNamed: "PlayerExplosion") {
    booom.position = location
    addChild(booom)
}
```
Showing
```swift
func show(hideTime: Double) {
    if isVisible { return }

    charNode.xScale = 1
    charNode.yScale = 1

    charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
    isVisible = true
    isHit = false

    if let fuse = SKEmitterNode(fileNamed: "PlayerExplosion") {
        addChild(fuse)
    }
...
```


## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

