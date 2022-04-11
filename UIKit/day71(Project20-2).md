# Day 71 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day70-71/Day70-71"> Project </a>

## Developing on SkriteKit

## Subjects

+ Wrap Up
+ Challenges

## Challenges

+ For an easy challenge try adding a score label that updates as the player’s score changes.
+ Make the game end after a certain number of launches. You will need to use the invalidate() method of Timer to stop it from repeating.
+ Use the waitForDuration and removeFromParent actions in a sequence to make sure explosion particle emitters are removed from the game scene when they are finished.

## For an easy challenge try adding a score label that updates as the player’s score changes.
```swift
var scoreLabel: SKLabelNode!
var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```
```swift
scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
scoreLabel.text = "Score: 0"
scoreLabel.position = CGPoint(x: 16, y: 16)
scoreLabel.horizontalAlignmentMode = .left
addChild(scoreLabel)
```
It's very easy as said. We've done this many times.

## Make the game end after a certain number of launches. You will need to use the invalidate() method of Timer to stop it from repeating.
```swift
var fireworkCount = 0{
    didSet{
        if fireworkCount == 3{
            self.gameTimer?.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                self.showDone = SKLabelNode(fontNamed: "Chalkduster")
                self.showDone!.text = "Show is done!"
                self.showDone!.position = CGPoint(x: 512, y: 368)
                self.showDone!.horizontalAlignmentMode = .center
                self.addChild(self.showDone!)
            }
        }
    }
}

var showDone: SKLabelNode?
```
```swift
@objc func launchFireworks() {
        self.fireworkCount += 1
...
```
We've done this many times before. Only I made an extra label appear here.

## Use the waitForDuration and removeFromParent actions in a sequence to make sure explosion particle emitters are removed from the game scene when they are finished.
```swift
let emitter = SKEmitterNode(fileNamed: "explode")!


let delayedRemoval = SKAction.sequence([
    SKAction.wait(forDuration: 3),
    SKAction.removeFromParent(),
])

emitter.position = firework.position
emitter.run(delayedRemoval)

addChild(emitter)

firework.removeFromParent()
```

We changed the codes a little for this part. With a 3 second delay we make sure that particle effect is deleted.

## Great Work :)

<img src="https://global-uploads.webflow.com/5e0ac69bad6badc677c5db21/6136efdd077934476ce23eb7_coder.gif" width="350" height="200"/>


