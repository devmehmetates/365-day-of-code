# Day 47 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day45-47"> Project </a>

## Developing on SpriteKit

## Subjects

+ Special effects: SKEmitterNode
+ Wrap Up
+ Challenges

## Special effects: SKEmitterNode
What we do is pretty simple. Adding a particle effect to the screen with the destroy method banana.
```swift
func destroy(ball: SKNode) {
    if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
        fireParticles.position = ball.position
        addChild(fireParticles)
    }

    ball.removeFromParent()
}
```

## Challenges

+ The pictures we’re using in have other ball pictures rather than just “ballRed”. Try writing code to use a random ball color each time they tap the screen.
+ Right now, users can tap anywhere to have a ball created there, which makes the game too easy. Try to force the Y value of new balls so they are near the top of the screen.
+ Give players a limit of five balls, then remove obstacle boxes when they are hit. Can they clear all the pins with just five balls? You could make it so that landing on a green slot gets them an extra ball.

### The pictures we’re using in have other ball pictures rather than just “ballRed”. Try writing code to use a random ball color each time they tap the screen.

The solution for this challenge was simple. First, I created a color list.
```swift
var colors = ["Red","Cyan","Yellow","Blue","Grey","Purple"]
```
And while creating the balls with a random number from this color list, I changed the asset name.
```swift
...
} else {
    let ball = SKSpriteNode(imageNamed:  "ball" + colors[Int.random(in: 0...colors.count - 1)])
...
```

### Right now, users can tap anywhere to have a ball created there, which makes the game too easy. Try to force the Y value of new balls so they are near the top of the screen.
Locations are CGPoints and we can divide it into parameters as x,y. So;
```swift
ball.position = CGPoint(x: location.x, y: 700)
```

### Give players a limit of five balls, then remove obstacle boxes when they are hit. Can they clear all the pins with just five balls? You could make it so that landing on a green slot gets them an extra ball.
Here is the hard part and of course the best. First, let's set our ball number as 5 and show it on the screen.

```swift
var ballLabel: SKLabelNode!

var ballCount :Int = 5 {
    didSet {
        ballLabel.text = "Remaining Ball: \(ballCount)"
    }
}
...

ballLabel = SKLabelNode(fontNamed: "Chalkduster")
ballLabel.text = "Remaining Ball: 5"
ballLabel.horizontalAlignmentMode = .right
ballLabel.position = CGPoint(x: 980, y: 650)
addChild(ballLabel)

```
Now, every time we create a ball, the number will decrease and give us a ball in the green areas.
```swift
...
ball.name = "ball"
ballCount -= 1
...

if object.name == "good" {
    destroy(ball: ball)
    score += 1
    ballCount += 1
...
```
Here comes the real fun. Let's create random pins to certain areas of the screen.
```swift
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
```
Pins explode when our balls hit them.
```swift
func pinsBetween(pins: SKNode, ball: SKNode) {
    if pins.name == "pins" || pins.name == nil {
        destroy(ball: pins)
    }
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
```
Here everything happened

## Great Work :)

<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="700" height="500"/>










