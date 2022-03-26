# Day 85 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day85-87/Day85-87"> Project </a>

## Developing on SpriteKit

## Subjects

+ Set-Up
+ Loading a level: categoryBitMask, collisionBitMask, contactTestBitMask

## Set-Up
Our standard game setup start

## Loading a level: categoryBitMask, collisionBitMask, contactTestBitMask
Today's episode is one but quite long. So let's get started without wasting time.

```swift
func loadLevel(){
    guard let levelURL = Bundle.main.url(forResource: "level1", withExtension: "txt") else {
        fatalError("Could not found level1.txt file")
    }
    guard let levelString = try? String(contentsOf: levelURL) else {
        fatalError("Coult not parse level1.txt file")
    }

    let lines = levelString.components(separatedBy: "\n")

    for (row, line) in lines.reversed().enumerated(){
        for (column, letter) in line.enumerated(){
            let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)

            if letter == "x"{
                let node = SKSpriteNode(imageNamed: "block")
                node.position = position

                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
                node.physicsBody?.isDynamic = false
                addChild(node)
            }else if letter == "v"{
                let node = SKSpriteNode(imageNamed: "vortex")
                node.name = "vortex"
                node.position = position
                node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
                node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                node.physicsBody?.isDynamic = false

                node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
                node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                node.physicsBody?.collisionBitMask = 0
                addChild(node)
            }else if letter == "s"{
                let node = SKSpriteNode(imageNamed: "star")
                node.name = "star"
                node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                node.physicsBody?.isDynamic = false

                node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
                node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                node.physicsBody?.collisionBitMask = 0
                node.position = position
                addChild(node)
            }else if letter == "f"{
                let node = SKSpriteNode(imageNamed: "finish")
                node.name = "finish"
                node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                node.physicsBody?.isDynamic = false

                node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
                node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                node.physicsBody?.collisionBitMask = 0
                node.position = position
                addChild(node)
            }else if letter == " "{

            }else{
                fatalError("Unknowed map letter \(letter)")
            }
        }
    }
}
```
In fact, as you can see, it seems to repeat itself, even though it is a long piece of code. Which it already is. We'll fix this in the next section. Let's take a look at what we just learned, shall we?

+ First of all, the level issue is really unique. We create a map according to the letters we give with a text file.
+ The meanings of each letter are clear. We place them in the right positions by making the right calculations.
+ Of course, the parts we place have different features and abilities.

```swift
enum CollisionTypes: UInt32{
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
}
```
We created an enum for collisions. The beauty of the given values is that;<br>
Even if all the possibilities except the finish are combined, the finish still cannot be achieved. Wonderful!<br>
There is one more thing we learned. Fatal error!

```swift
fatalError("Unknowed map letter \(letter)")
```
Our app crashes, but there is no situation that tells us why it crashed. For this, there is a feature that will help us where crashes may occur.

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

