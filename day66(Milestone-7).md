# Day 66 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day66-Challenge/Day66-Challenge"> Project </a>

## A duck hunting game

## Challenge
I solved the problem with incredible thought in this game which is a great challenge altogether. I don't know if it's really the right approach, but it definitely works. I'm seriously tired to prepare a document since it's too hard to write the codes this time. This challenge is really compelling. The project is here. Here I will briefly describe the steps. I will also add small code samples. All it is.

+ The first step was to add 3 backgrounds. It was pretty simple.
+ The gravity thing in the game we played before came to my mind. I said why not? How about we lift the gravity and push the ducks a little? Thus, the samples were created in the positions we wanted. They were oriented and pushed. This made them look like they were going on a straight line. This is not a problem as they cannot collide with each other.
+ The samples are moving in a certain order. But they are very simple. In order to complicate the game, the ducks accelerate according to the number of ducks formed. This makes them harder to hit.
+ The duration is quite long. Because the game is really hard. You ask why ?
+ As if that weren't enough, we have a gun that is limited to 5 rounds. Of course, there is no autofill feature either. Of course, there is a label that you have to touch to be able to reload.
+ As if that wasn't enough, we also have 2 types of ducks. I have not touched the issue of size by being a little fair here. The ducks that take points are small and if you hit them, your 25 points will turn into dust.

### Summary
+ A weapon with 5 bullet and without auto-reload. RAMBO!
+ Two types of ducks, constantly accelerating and target or friend.
+ 5 minute time limit.

## Useful pieces of code
```swift
@objc func createTarget() {
    guard let pos = enemyCreatePos.randomElement() else { return }
    guard let posY = pos.value.randomElement() else { return }
    guard let target = posibility.randomElement() else { return }
    duckCount += 1

    let sprite = SKSpriteNode(imageNamed: target)
    sprite.position = CGPoint(x: pos.key, y: posY)
    sprite.name = target
    addChild(sprite)

    sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
    sprite.physicsBody?.categoryBitMask = 1
    if pos.key == -100{
        sprite.physicsBody?.velocity = CGVector(dx: self.duckSpeed, dy: 0)
    }else{
        sprite.xScale = -1
        sprite.physicsBody?.velocity = CGVector(dx: -self.duckSpeed, dy: 0)
    }

}
```
```swift
if endTime != 0{
    if objects.contains(bulletLabel){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.bullet > 0{
                self.bullet += 5 - self.bullet
            }else{
                self.bullet += 5
            }

        }
    }else{
        if self.bullet > 0{
            bullet -= 1
            if !objects.isEmpty{
                for object in objects {
                    if object.name == "friend"{
                        score -= 25
                        object.removeFromParent()
                    }else if object.name == "duck"{
                        score += 5
                        object.removeFromParent()
                    }
                }
            }
        }
    }
}
```
It's up to you to add meaning to the codes.

## Great Work :)
<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="700" height="500"/>

