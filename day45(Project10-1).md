# Day 45 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day45-47"> Project </a>

## Developing on SpriteKit

## Subjects

+ Setting-Up
+ Falling boxes: SKSpriteNode, UITouch, SKPhysicsBody
+ Bouncing balls: circleOfRadius

## Setting-Up 
I will write a setting-up description for the first time. Because today we are starting a game not an iOS app. What to do is simple. Select the game in installation, set ipad as device and remove some of the orientations. We're ready to start, are your seat belts fastened?

## Falling boxes: SKSpriteNode, UITouch, SKPhysicsBody
Our priority is this. Completely clean the demo game that comes by default. Then we can start the process.
```swift
...
override func didMove(to view: SKView) {
}
...
```
Here let's set our background.
```swift
...
override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)
...
```
We set the background as a node from the pictures we took. We centered it, changed the color mix, and finally dumped it into the background.

```swift
physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
```
```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else{ return }
    let location = touch.location(in: self)

    let box = SKSpriteNode(color: .red, size: CGSize(width: 64, height: 64))
    box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
    box.position = location
    addChild(box)
}
```
Boxes falling from the point we clicked? Here they are.

## Bouncing balls: circleOfRadius
```swift
...
let ball = SKSpriteNode(imageNamed: "ballBlue")
ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
ball.physicsBody?.restitution = 0.5 // Bounce
ball.position = location
addChild(ball)
...
```
How about turning the boxes into balls? Use circle instead of rectangle. And add bounce feature.

```swift
func makeBouncer(position : CGPoint){
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
    bouncer.position = position
    bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width/2)
    bouncer.physicsBody?.isDynamic = false
    addChild(bouncer)
}
```
We have to have a bouncing ball that stays steady and triggers physics. Right there. And place them row by row at the bottom of the screen.

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

