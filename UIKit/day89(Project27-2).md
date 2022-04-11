# Day 89 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day88-89/Day88-89"> Project </a>

## Developing on Core Graphics

## Subjects

+ Wrap Up
+ Challenges

## Challenges

+ Pick any emoji and try creating it using Core Graphics. You should find some easy enough, but for a harder challenge you could also try something like the star emoji.
+ Use a combination of move(to:) and addLine(to:) to create and stroke a path that spells “TWIN” on the canvas.
+ Go back to project 3 and change the way the selected image is shared so that it has some rendered text on top saying “From Storm Viewer”. This means reading the size property of the original image, creating a new canvas at that size, drawing the image in, then adding your text on top.

## Pick any emoji and try creating it using Core Graphics. You should find some easy enough, but for a harder challenge you could also try something like the star emoji.
Hi again. Let's start today with a small challenge. I have to admit that I got a little carried away here. Hello sad face emoji 👋🏼.

```swift
func drawEmote(){
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

    let img = renderer.image { ctx in
        let rectangle = CGRect(x: 66, y: 66, width: 400, height: 400)
            .insetBy(dx: 5, dy: 5)
        let eye1 = CGRect(x: 150, y: 200, width: 30, height: 40)
        let eye2 = CGRect(x: 350, y: 200, width: 30, height: 40)
        let mount = CGRect(x: 150, y: 330, width: 230, height: 3)

        ctx.cgContext.setFillColor(UIColor.clear.cgColor)
        ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
        ctx.cgContext.setLineWidth(3)


        ctx.cgContext.addEllipse(in: rectangle)
        ctx.cgContext.addEllipse(in: eye1)
        ctx.cgContext.addEllipse(in: eye2)
        ctx.cgContext.addRect(mount)
        ctx.cgContext.drawPath(using: .stroke)
    }

    imageView.image = img
}
```

## Use a combination of move(to:) and addLine(to:) to create and stroke a path that spells “TWIN” on the canvas.
In this section the codes explain everything. After studying it, you will begin to understand very well.
```swift
func drawTwin(){
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))

    let img = renderer.image { ctx in
        ctx.cgContext.translateBy(x: 170, y: 256)

        // T
        ctx.cgContext.move(to: CGPoint(x: -30, y: 1))
        ctx.cgContext.addLine(to: CGPoint(x: 30, y: 1))
        ctx.cgContext.move(to: CGPoint(x: 0, y: 0))
        ctx.cgContext.addLine(to: CGPoint(x: 0, y: 60))

        // W
        ctx.cgContext.move(to: CGPoint(x: 40, y: 0))
        ctx.cgContext.addLine(to: CGPoint(x: 60, y: 60))
        ctx.cgContext.move(to: CGPoint(x: 60, y: 60))
        ctx.cgContext.addLine(to: CGPoint(x: 80, y: 0))
        ctx.cgContext.move(to: CGPoint(x: 80, y: 0))
        ctx.cgContext.addLine(to: CGPoint(x: 100, y: 60))
        ctx.cgContext.move(to: CGPoint(x: 100, y: 60))
        ctx.cgContext.addLine(to: CGPoint(x: 120, y: 0))

        // I
        ctx.cgContext.move(to: CGPoint(x: 130, y: 0))
        ctx.cgContext.addLine(to: CGPoint(x: 130, y: 60))

        // N
        ctx.cgContext.move(to: CGPoint(x: 140, y: 0))
        ctx.cgContext.addLine(to: CGPoint(x: 140, y: 60))
        ctx.cgContext.move(to: CGPoint(x: 140, y: 0))
        ctx.cgContext.addLine(to: CGPoint(x: 180, y: 60))
        ctx.cgContext.move(to: CGPoint(x: 180, y: 60))
        ctx.cgContext.addLine(to: CGPoint(x: 180, y: 0))

        ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
        ctx.cgContext.strokePath()
    }

    imageView.image = img   
}
```

## Go back to project 3 and change the way the selected image is shared so that it has some rendered text on top saying “From Storm Viewer”. This means reading the size property of the original image, creating a new canvas at that size, drawing the image in, then adding your text on top.
We changed the tiny codes of the project we did a long time ago.

```swift
@objc func shareTabbed(){
    guard let imageSize = imageView.image?.size else{ return }

    let renderer = UIGraphicsImageRenderer(size: imageSize)

    let willShareImage = renderer.image { ctx in
        imageView.image?.draw(at: CGPoint(x: 0, y: 0))

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 36),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ]
        let string = "From Storm Viewer"
        let attributedString = NSAttributedString(string: string, attributes: attrs)

        attributedString.draw(with: CGRect(x: 260, y: 32, width: imageSize.width / 2, height: imageSize.height / 2), options: .usesLineFragmentOrigin, context: nil)

    }
    
    guard let image = willShareImage.jpegData(compressionQuality: 0.8) else{
        print("No image found")
        return
    }

    guard let imageName = selectedImage else{
        print("No image selected")
        return
    }
    let vc = UIActivityViewController(activityItems: [image,imageName], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem

    present(vc,animated: true)
}
```
As in the challenge sentence; 
This means reading the size property of the original image, creating a new canvas at that size, drawing the image in, then adding your text on top.


## Happiness at Apple

<img src="https://applemagazine.com/wp-content/uploads/2021/03/e1a75d9ce16241ab960a1e84ed70eeed.gif" width="350" height="200"/>
