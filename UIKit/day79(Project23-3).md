# Day 79 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day77-79/Day77-79"> Project </a>

## Developing on SpriteKit


## Challenges
+ Try removing the magic numbers in the createEnemy() method. Instead, define them as constant properties of your class, giving them useful names.
+ Create a new, fast-moving type of enemy that awards the player bonus points if they hit it.
+ Add a “Game over” sprite node to the game scene when the player loses all their lives.


##  Try removing the magic numbers in the createEnemy() method. Instead, define them as constant properties of your class, giving them useful names.
What we're doing is pretty simple actually. But it was important in programming. Naming numbers with meaningful variables instead of using numbers unintentionally improves code understandability. Really simple but effective.

```swift
let popupTimeConstants = 0.991
let chainDelayConstants = 0.99
let wordSpeedConstants = 1.02
let minXConstants = 64
let maxXConstants = 960
let creationYConstants = -128
let minAngularVelocityConstants : CGFloat = -3
let maxAngularVelocityConstants : CGFloat = 3
let minFastXVelocityConstants = 8
let maxFastXVelocityConstants = 15
let minSlowXVelocityConstants = 3
let maxSlowXVelocityConstants = 5
let minYVelocityConstants = 24
let maxYVelocityConstants = 32
let physicsVelocityMultiplierConstants = 40
let physicsFastVelocityMultiplierConstants = 70
```
I misunderstood the situation and converted the values in another part to constant. But no problem. Let's see the use of them, what do you say?
```swift
let randomPosition = CGPoint(x: Int.random(in: minXConstants...maxXConstants), y: creationYConstants)
enemy.position = randomPosition

let randomAngularVelocity = CGFloat.random(in: minAngularVelocityConstants...maxAngularVelocityConstants )
let randomXVelocity: Int

if randomPosition.x < 256 {
    randomXVelocity = Int.random(in: minFastXVelocityConstants...maxFastXVelocityConstants)
} else if randomPosition.x < 512 {
    randomXVelocity = Int.random(in: minSlowXVelocityConstants...maxSlowXVelocityConstants)
} else if randomPosition.x < 768 {
    randomXVelocity = -Int.random(in: minSlowXVelocityConstants...maxSlowXVelocityConstants)
} else {
    randomXVelocity = -Int.random(in: minFastXVelocityConstants...minFastXVelocityConstants)
}

let randomYVelocity = Int.random(in: minYVelocityConstants...maxYVelocityConstants)

enemy.physicsBody = SKPhysicsBody(circleOfRadius: 64)
if enemyType == 7{
    enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * physicsFastVelocityMultiplierConstants, dy: randomYVelocity * physicsVelocityMultiplierConstants)
}else{
    enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * physicsVelocityMultiplierConstants, dy: randomYVelocity * physicsVelocityMultiplierConstants)
}
```
LOTS OF CODES. All from what we've written before. Except some of them :)

## Create a new, fast-moving type of enemy that awards the player bonus points if they hit it.
Probably the first challenge was warm-up, the second was to test us, and the third was to cool us down. It's pure sports logic. Now let's add a very fast object worth 25 points to our game.

```swift
enum SequenceType: CaseIterable {
    case oneNoBomb, one, twoWithOneBomb, two, three, four, chain, fastChain, bonus
}
```
The first thing I do is create a new option. So we can give a probability. Of course, that's worth killing 25 penguins. So we have to make it as difficult as possible. The challenge just says to be fast, but if we put lots of bombs around it, it won't do much harm.

```swift
case .bonus:
    createEnemy(isBonus: true)
    createEnemy(forceBomb: .always)
    createEnemy(forceBomb: .always)
    createEnemy(forceBomb: .always)
    createEnemy(forceBomb: .always)
}
```
Lots of bombs for bonus. Of course, we need to update the create enemy for this.
```swift
func createEnemy(forceBomb: ForceBomb = .random, isBonus: Bool? = false) {
```
First of all, is this a bonus?

```swift
var enemyType = Int.random(in: 0...6)

if isBonus!{
    enemyType = 7
}
```
If not, act natural. But if it's a bonus, identify it.

```swift
} else if enemyType == 7{
    enemy = SKSpriteNode(imageNamed: "hammer")
    run(SKAction.playSoundFileNamed("launch.caf", waitForCompletion: false))
    enemy.name = "bonus"
}else {
    enemy = SKSpriteNode(imageNamed: "penguin")
    run(SKAction.playSoundFileNamed("launch.caf", waitForCompletion: false))
    enemy.name = "enemy"
}
```
I copied it this way to show that it is exactly the same. Our assets and names are different, that's all.


```swift
if enemyType == 7{
            enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * physicsFastVelocityMultiplierConstants, dy: randomYVelocity * physicsVelocityMultiplierConstants)
        }else{
            enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * physicsVelocityMultiplierConstants, dy: randomYVelocity * physicsVelocityMultiplierConstants)
        }
```
Well that's a bonus. It has to be difficult. We can't throw at the same speed. So let's use the constants from the previous challenge.


```swift
if node.name == "enemy" || node.name == "bonus" {
    if let emitter = SKEmitterNode(fileNamed: "sliceHitEnemy") {
        emitter.position = node.position
        addChild(emitter)
    }
    if node.name == "bonus"{
        score += 25
    }else{
        score += 1
    }
    node.name = ""
    node.physicsBody?.isDynamic = false
    let scaleOut = SKAction.scale(to: 0.001, duration:0.2)
    let fadeOut = SKAction.fadeOut(withDuration: 0.2)
    let group = SKAction.group([scaleOut, fadeOut])
    let seq = SKAction.sequence([group, .removeFromParent()])
    node.run(seq)

    if let index = activeEnemies.firstIndex(of: node) {
        activeEnemies.remove(at: index)
    }
    run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
}
```

As a result it has the same function as a penguin. Just more valuable. We don't need to write empty code. All we have to do is add more points if it's called a bonus.


## Add a “Game over” sprite node to the game scene when the player loses all their lives.
We could find the game over asset and do the same thing with a sprite node. We just had to set is dynamic to false for it to hang in mid-air.

```swift
var gameOver: SKLabelNode?
```

```swift
func createGameOver(){
    gameOver = SKLabelNode(fontNamed: "Chalkduster")
    gameOver?.text = "Game Over"
    gameOver?.horizontalAlignmentMode = .center
    gameOver?.fontSize = 48
    addChild(gameOver!)

    gameOver?.position = CGPoint(x: 512, y: 368)
}
```
I chose this instead.

```swift
func endGame(triggeredByBomb: Bool) {
    if isGameEnded {
        return
    }

    isGameEnded = true
    createGameOver()
```
And when the game is over i called it. Here is our Swifty Ninja.

## Good Work :)
<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

