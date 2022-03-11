# Day 70 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day70-71/Day70-71"> Project </a>

## Developing on SpriteKit

## Subjects

+ Set-Up
+ Ready... aim... fire: Timer and follow()
+ Swipe to select

## Set-Up
Our standard game setup start

##  Ready... aim... fire: Timer and follow()
I know there is a lot of code, but I did not write them. I watched the videos and learned how they work. Then I placed it properly. Otherwise it's really tiring...
Let's start explaining.
```swift
var gameTimer: Timer?
var fireworks = [SKNode]()

let leftEdge = -22
let bottomEdge = -22
let rightEdge = 1024 + 22

var score = 0 {
    didSet {
       
    }
}
```
Let's define what we will use! It's pretty simple.


```swift
override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)

    gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
}
```
Let's place our beautiful picture as a background. Then let's set a timer that fires 1 firework every 6 seconds.


```swift
func createFirework(xMovement: CGFloat, x: Int, y: Int) {
    let node = SKNode()
    node.position = CGPoint(x: x, y: y)

    let firework = SKSpriteNode(imageNamed: "rocket")
    firework.colorBlendFactor = 1
    firework.name = "firework"
    node.addChild(firework)

    switch Int.random(in: 0...2) {
    case 0:
        firework.color = .cyan

    case 1:
        firework.color = .green

    case 2:
        firework.color = .red

    default:
        break
    }

    let path = UIBezierPath()
    path.move(to: .zero)
    path.addLine(to: CGPoint(x: xMovement, y: 1000))

    let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
    node.run(move)

    if let emitter = SKEmitterNode(fileNamed: "fuse") {
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
    }

    fireworks.append(node)
    addChild(node)
}
```
This is the part that is different. This actually creates a single firework. It puts them on a certain route. <code>UIBezierPath</code> Here's using it. Then we put a fire effect at the end of our rocket. Wonderful!


```swift
@objc func launchFireworks() {
    let movementAmount: CGFloat = 1800

    switch Int.random(in: 0...3) {
    case 0:
        // fire five, straight up
        createFirework(xMovement: 0, x: 512, y: bottomEdge)
        createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge)
        createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
        createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge)
        createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)

    case 1:
        // fire five, in a fan
        createFirework(xMovement: 0, x: 512, y: bottomEdge)
        createFirework(xMovement: -200, x: 512 - 200, y: bottomEdge)
        createFirework(xMovement: -100, x: 512 - 100, y: bottomEdge)
        createFirework(xMovement: 100, x: 512 + 100, y: bottomEdge)
        createFirework(xMovement: 200, x: 512 + 200, y: bottomEdge)

    case 2:
        // fire five, from the left to the right
        createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
        createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
        createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
        createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
        createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)

    case 3:
        // fire five, from the right to the left
        createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
        createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
        createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
        createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
        createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)

    default:
        break
    }
}
```
This is purely mathematical. We indicate firework placements and orientations. If you noticed, they are all in groups of 5. This is actually our fireworks series.

## Swipe to select
When our conversations hover over their fireworks, we want to change their color. This is pretty easy.

```swift
func checkTouches(_ touches: Set<UITouch>) {
    guard let touch = touches.first else { return }

    let location = touch.location(in: self)
    let nodesAtPoint = nodes(at: location)

    for case let node as SKSpriteNode in nodesAtPoint {
        guard node.name == "firework" else { continue }

        for parent in fireworks {
            guard let firework = parent.children.first as? SKSpriteNode else { continue }

            if firework.name == "selected" && firework.color != node.color {
                firework.name = "firework"
                firework.colorBlendFactor = 1
            }
        }
        node.name = "selected"
        node.colorBlendFactor = 0
    }
}

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    checkTouches(touches)
}

override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    checkTouches(touches)
}
```
If our touches contain a firework, mark it as selected and change its color. It's really easy.

```swift
override func update(_ currentTime: TimeInterval) {
    for (index, firework) in fireworks.enumerated().reversed() {
        if firework.position.y > 900 {
            // this uses a position high above so that rockets can explode off screen
            fireworks.remove(at: index)
            firework.removeFromParent()
        }
    }
}
```
Finally, we delete the firework after it exits the screen to avoid excessive memory usage.

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

