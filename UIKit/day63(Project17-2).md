# Day 63 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day62-63/Day62-63"> Project </a>

## Developing on SpriteKit

## Subjects

+ Wrap Up
+ Challenges

## Challenges

+ Stop the player from cheating by lifting their finger and tapping elsewhere – try implementing touchesEnded() to make it work.
+ Make the timer start at one second, but then after 20 enemies have been made subtract 0.1 seconds from it so it’s triggered every 0.9 seconds. After making 20 more, subtract another 0.1, and so on. Note: you should call invalidate() on gameTimer before giving it a new value, otherwise you end up with multiple timers.
+ Stop creating space debris after the player has died.

## Stop the player from cheating by lifting their finger and tapping elsewhere – try implementing touchesEnded() to make it work.
In fact, it seemed weird to me to pop the user the moment it lifted his finger. If I didn't touch a certain area around the rocket, it shouldn't move! I was thinking of preventing cheating by saying. But no problem.
```swift
override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if !isGameOver {
        if self.contains(player){
            let explosion = SKEmitterNode(fileNamed: "explosion")!
            explosion.position = player.position
            addChild(explosion)

            player.removeFromParent()

            isGameOver = true
        }
    }
}
```

## Make the timer start at one second, but then after 20 enemies have been made subtract 0.1 seconds from it so it’s triggered every 0.9 seconds. After making 20 more, subtract another 0.1, and so on. Note: you should call invalidate() on gameTimer before giving it a new value, otherwise you end up with multiple timers.
```swift
var enemyCount: Int = 0{
    didSet{
        if enemyCount > 40{
            self.timeInver = 0.1
        }
        else if enemyCount.isMultiple(of: 5){
            self.gameTimer?.invalidate()
            self.timeInver -= 0.1
            self.gameTimer = Timer.scheduledTimer(timeInterval: timeInver, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        }

    }
}
var timeInver = 1.0
```

## Stop creating space debris after the player has died.
```swift
if !isGameOver {
    score += 1
}else{
    self.gameTimer?.invalidate()
}
```

For the first time, a day of difficulty made me feel bored. I think I will add something about restarting the game and do bonus challenges for myself.


## Great Work :)

<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="700" height="500"/>


