# Day 87 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day85-87/Day85-87"> Project </a>

## Developing on SpriteKit

## Subjects

+ Wrap Up
+ Challenges

## Challenges

+ Rewrite the loadLevel() method so that it's made up of multiple smaller methods. This will make your code easier to read and easier to maintain, or at least it should do if you do a good job!
+ When the player finally makes it to the finish marker, nothing happens. What should happen? Well, that's down to you now. You could easily design several new levels and have them progress through.
+ Add a new block type, such as a teleport that moves the player from one teleport point to the other. Add a new letter type in loadLevel(), add another collision type to our enum, then see what you can do.

## Rewrite the loadLevel() method so that it's made up of multiple smaller methods. This will make your code easier to read and easier to maintain, or at least it should do if you do a good job!
All right, let's get started. A refactoring challenge. I said that there are too many repetitive elements inside the function. I edited them with a method.

```swift 
func createGameObject(name: String, position: CGPoint, type: CollisionTypes, action: (_ node: SKSpriteNode) -> Void = {node in }, isBlock: Bool = false){
    let node = SKSpriteNode(imageNamed: name)
    node.name = name
    action(node)
    if !isBlock{
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
    }else{
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
    }
    node.physicsBody?.isDynamic = false
    node.physicsBody?.categoryBitMask = type.rawValue
    if !isBlock{
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
    }
    node.physicsBody?.collisionBitMask = 0
    node.position = position
    addChild(node)
}
```
I took care of the differences using closures and a few parameters. Let's look at the vortex formation as an example.

```swift
// BEFORE
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

// AFTER
createGameObject(name: "vortex", position: position, type: CollisionTypes.vortex) { node in
    node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
}
```

## When the player finally makes it to the finish marker, nothing happens. What should happen? Well, that's down to you now. You could easily design several new levels and have them progress through.
Yes we didn't have any code for the new lvl. But before we do that, we also need a new lvl.

```txt
xxxxxxxxxxxxxxxx
x xxvvvxxxxvvvfx
x xxs          x
x xx  x xxxxxexx
x xv vx       sx
x xv vx vvvvv sx
x xv vx vvvvvvvx
x xv vx      ssx
x xsssx xxxxxxxx
x xtxxx       sx
x       vvvvvvvx
xxxxxxxxxxxxxxxx
```
The features we added in the 3rd challenge are currently available, but don't get hung up on it. Yes the level is ready now how do we switch it to lvl.

```swift
var levelCount: Int = 1

func loadLevel(level: Int){
  guard let levelURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") else {
  ...
  
else if node.name == "finish" {
   // Next level codes
    removeAllChildren()
    setBackgroundAndScore()
    createPlayer()
    levelCount += 1
    loadLevel(level: levelCount)
    physicsWorld.gravity = .zero
}
```

```swift
func setBackgroundAndScore(){
    let background = SKSpriteNode(imageNamed: "background.jpg")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)

    scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    scoreLabel.text = "Score: 0"
    scoreLabel.horizontalAlignmentMode = .left
    scoreLabel.position = CGPoint(x: 16, y: 16)
    scoreLabel.zPosition = 2
    addChild(scoreLabel)
}
```

```swift
 override func didMove(to view: SKView) {
    setBackgroundAndScore()
    loadLevel(level: levelCount)
```

I will quickly summarize this part, which consists of many parts. 
+ Our priority is to update the load level mothod. This part makes up everything.
+ If we don't delete everything about the old lvl while loading our new lvl, it means mess in the new lvl. 
+ That's why we delete and recreate everything. The most important detail while doing this is gravity.
+ We set the gravity to 0 so that the previous effects are not applied at the beginning of the new lvl.
+ Well, in doing so, our background and leaderboard disappear. Therefore, we write and call a small method in them.

## Add a new block type, such as a teleport that moves the player from one teleport point to the other. Add a new letter type in loadLevel(), add another collision type to our enum, then see what you can do.
Here is the bomb part of the challenge. Let's build a teleport machine.
```swift
case teleport = 16
case finish = 32

var teleportExitPoint = CGPoint(x: 0, y: 0)
```

```swift
}else if letter == "t"{
    createGameObject(name: "teleport", position: position, type: CollisionTypes.teleport)
}else if letter == "e"{
    self.teleportExitPoint = position
    createGameObject(name: "teleport-exit", position: position, type: CollisionTypes.teleport)
}
```

```swift
else if node.name == "teleport"{
    player.physicsBody?.isDynamic = false
    isGameOver = true
    let move = SKAction.move(to: node.position, duration: 0.25)
    let scale = SKAction.scale(to: 0.0001, duration: 0.25)
    let remove = SKAction.removeFromParent()
    let sequence = SKAction.sequence([move, scale, remove])
    player.run(sequence) { [weak self] in
        self?.createPlayer()
        self?.player.position = self!.teleportExitPoint
        self?.isGameOver = false
    }
}
```
Some codes sound familiar? Yes, of course, this is almost the same as vortex codes. When we think logically, a black hole swallows us and sends us to the very beginning. All we have to do is change where we started. I also solved this by assigning the location of the teleport exit point to a variable.

## Happiness at Apple

<img src="https://applemagazine.com/wp-content/uploads/2021/03/e1a75d9ce16241ab960a1e84ed70eeed.gif" width="350" height="200"/>


