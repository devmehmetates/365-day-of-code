# Day 88 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day88-89/Day88-89"> Project </a>

## Developing on Extensions

## Subjects
+ Setting up
+ Creating the sandbox
+ Drawing into a Core Graphics context with UIGraphicsImageRenderer
+ Ellipses and checkerboards
+ Transforms and lines
+ Images and text

## Creating the sandbox
I certainly don't need to tire you out today. Let's quickly summarize what we did.

+ We designed a small view on the story board.
+ View is completely covered with image-view and there is a small button above it.
+ Then we connect them to the view controller using the assistant.

## Drawing into a Core Graphics context with UIGraphicsImageRenderer
I really don't need to write extra explanations for this and the next chapters. It's all done with mathematical calculations and some core graphics capabilities. To avoid too much code duplication, I'll share just one section, which is a really great computational example.

+ In this section, we defined a variable and made it possible to draw a different shape with each click of the button.

## Transforms and lines
```swift
func drawLines() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

    let img = renderer.image { ctx in
        ctx.cgContext.translateBy(x: 256, y: 256)

        var first = true
        var length: CGFloat = 256

        for _ in 0 ..< 256 {
            ctx.cgContext.rotate(by: .pi / 2)

            if first {
                ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                first = false
            } else {
                ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
            }

            length *= 0.99
        }

        ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
        ctx.cgContext.strokePath()
    }

    imageView.image = img
}
```
We are talking about lines that constantly rotate 90 degrees. And we increase the lengths of these lines each time. You should definitely try creating this image.


## Happy Coding :)
<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

