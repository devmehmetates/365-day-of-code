# Day 55 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day55-56/Day55-56"> Project </a>

## Developing on SpriteKit

## Subjects

+ Setting-Up
+ Getting up and running: SKCropNode
+ Penguin, show thyself: SKAction moveBy(x:y:duration:)

## Setting-Up 
I will write a setting-up description for the first time. Because today we are starting a game not an iOS app. What to do is simple. Select the game in installation, set ipad as device and remove some of the orientations. As in Project 11.

## Getting up and running: SKCropNode
```swift
var gameScore: SKLabelNode!
var score = 0 {
    didSet {
        gameScore.text = "Score: \(score)"
    }
}
```

```swift
override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "whackBackground")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)

    gameScore = SKLabelNode(fontNamed: "Chalkduster")
    gameScore.text = "Score: 0"
    gameScore.position = CGPoint(x: 8, y: 8)
    gameScore.horizontalAlignmentMode = .left
    gameScore.fontSize = 48
    addChild(gameScore)
}
```
Here let's set our background and score label.

```swift
class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    
    func configure(at position: CGPoint) {
        self.position = position

        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
    }
}
```
```swift
var slots = [WhackSlot]()

func createSlot(at position: CGPoint) {
    let slot = WhackSlot()
    slot.configure(at: position)
    addChild(slot)
    slots.append(slot)
}
```

```swift
override func didMove(to view: SKView) {
    ...
    for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
    for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
    for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
    for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
}
```
Yes we should be seeing a lot of potholes now.

```swift
func configure(as position: CGPoint){
    self.position = position

    let sprite = SKSpriteNode(imageNamed: "whackHole")
    addChild(sprite)

    let cropNode = SKCropNode()
    cropNode.position = CGPoint(x: 0, y: 15)
    cropNode.zPosition = 1
    cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")

    charNode = SKSpriteNode(imageNamed: "penguinGood")
    charNode.position = CGPoint(x: 0, y: -90)
    charNode.name = "character"
    cropNode.addChild(charNode)

    addChild(cropNode)
}
```
We have also added hideable penguins into our pits. Penguins are 15 px below and above the mask. so they will only show up when they go up :)

## Penguin, show thyself: SKAction moveBy(x:y:duration:)
```swift
var isVisible = false
var isHit = false

func show(hideTime: Double) {
    if isVisible { return }

    charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
    isVisible = true
    isHit = false

    if Int.random(in: 0...2) == 0 {
        charNode.texture = SKTexture(imageNamed: "penguinGood")
        charNode.name = "charFriend"
    } else {
        charNode.texture = SKTexture(imageNamed: "penguinEvil")
        charNode.name = "charEnemy"
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
        self?.hide()
    }
}

func hide() {
    if !isVisible { return }

    charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
    isVisible = false
}
```

```swift
var popupTime = 0.85

func createEnemy() {
    popupTime *= 0.991

    slots.shuffle()
    slots[0].show(hideTime: popupTime)

    if Int.random(in: 0...12) > 4 { slots[1].show(hideTime: popupTime) }
    if Int.random(in: 0...12) > 8 {  slots[2].show(hideTime: popupTime) }
    if Int.random(in: 0...12) > 10 { slots[3].show(hideTime: popupTime) }
    if Int.random(in: 0...12) > 11 { slots[4].show(hideTime: popupTime)  }

    let minDelay = popupTime / 2.0
    let maxDelay = popupTime * 2
    let delay = Double.random(in: minDelay...maxDelay)

    DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
        self?.createEnemy()
    }
}
```

An important and beautiful episode. So why? <br>
Here, the exit times are constantly processed, which makes the game more difficult.A randomly generated series of penguin that gets faster and faster. Cool!

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

