# Day 46 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day45-47"> Project </a>

## Developing on SpriteKit

## Subjects

+ Spinning slots: SKAction
+ Collision detection: SKPhysicsContactDelegate
+ Scores on the board: SKLabelNode

## Spinning slots: SKAction
```swift
...
func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode

    if isGood {
        slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
    } else {
        slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
    }

    slotBase.position = position
    addChild(slotBase)
}
...
```
Yes, here we are actually creating sticks. We place it on the screen according to a position and change its types according to boolean.
After, we need the call this function.
```swift
makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
```

Now let's add a glow effect here and rotate them forever.
```swift
...
var slotGlow: SKSpriteNode

if isGood {
    slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
    slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
} else {
    slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
    slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
}

slotBase.position = position
slotGlow.position = position


let spin = SKAction.rotate(byAngle: .pi, duration: 10)
let spinForever = SKAction.repeatForever(spin)
slotGlow.run(spinForever)
...
```

## Collision detection: SKPhysicsContactDelegate
The balls we made here will disappear when they hit the points we set.

For this, we have to give them a skeleton-like description.
```swift
...
physicsWorld.contactDelegate = self
...
ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
...
```

Then let's name them and write functions that will understand their collisions.
```swift
...
slotBase.name = "good"
slotBase.name = "bad"
ball.name = "ball"
...

func collisionBetween(ball: SKNode, object: SKNode) {
    if object.name == "good" {
        destroy(ball: ball)
    } else if object.name == "bad" {
        destroy(ball: ball)
    }
}

func destroy(ball: SKNode) {
    ball.removeFromParent()
}

func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }

    if nodeA.name == "ball" {
        collisionBetween(ball: nodeA, object: nodeB)
    } else if nodeB.name == "ball" {
        collisionBetween(ball: nodeB, object: nodeA)
    }
}
```

## Scores on the board: SKLabelNode
Here, we create the edit button with the score.

```swift
var scoreLabel: SKLabelNode!

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
```
Let's put them on the screen.

```swift
scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
scoreLabel.text = "Score: 0"
scoreLabel.horizontalAlignmentMode = .right
scoreLabel.position = CGPoint(x: 980, y: 700)
addChild(scoreLabel)

editLabel = SKLabelNode(fontNamed: "Chalkduster")
editLabel.text = "Edit"
editLabel.position = CGPoint(x: 80, y: 700)
addChild(editLabel)
```
Very beautiful, now let's reduce the score or up.
```swift
func collisionBetween(ball: SKNode, object: SKNode) {
    if object.name == "good" {
        destroy(ball: ball)
        score += 1 // here
    } else if object.name == "bad" {
        destroy(ball: ball)
        score -= 1 // here
    }
}
```
Now let's decide what happens in edit mode.
```swift
// First Part
let objects = nodes(at: location)

if objects.contains(editLabel) {
    editingMode.toggle()
} else {
    // Second Part
    if editingMode {
        let size = CGSize(width: Int.random(in: 16...128), height: 16)
        let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
        box.zRotation = CGFloat.random(in: 0...3)
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false
        addChild(box)
    } else {
        // Third Part
        let ball = SKSpriteNode(imageNamed: "ballBlue")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.restitution = 0.5
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        ball.position = location
        ball.name = "ball"
        addChild(ball)
    }
}
```

First Part<br>
Do we have an editlabel where it is clicked? toggle the bool value if it exists.

Second Part<br>
If edit mode is turned on, create boxes of random length and direction and place them in the click position.

Third Part<br>
Create our balls if edit mode is turned off.



## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

