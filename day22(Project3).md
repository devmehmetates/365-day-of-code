# Day 22 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day22"> Project </a>

## Begin to the iOS

## Subjects

+ UIActivityViewController explained
+ Wrap Up (Challenges)

## UIActivityViewController explained

Actually, that's all the codes that affect this subject
```swift
let vc = UIActivityViewController(activityItems: [image,imageName], applicationActivities: [])
vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem    
present(vc,animated: true)
```

But besides that, there is a navigation button that we run these codes and we just learned.
```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTabbed))
```

And of course our sample of data we get to be able to import and save the pictures.
```swift
guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else{
    print("No image found")
    return
}
```
## Challenge

### Try adding the image name to the list of items that are shared. The activityItems parameter is an array, so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share options will.

```swift
guard let imageName = selectedImage else{
    print("No image selected")
    return
}
let vc = UIActivityViewController(activityItems: [image,imageName], applicationActivities: [])
```

### Go back to project 1 and add a bar button item to the main view controller that recommends the app to other people.
```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onTab))

@objc func onTab(){
    let message = "This's awesome app. You should be try :)"
    let appLink = "https://github.com/devmehmetates"

    let vc  = UIActivityViewController(activityItems: [message,appLink], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem

    present(vc,animated: true)
}
```

### Go back to project 2 and add a bar button item that shows their score when tapped.

```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onTab))


@objc func onTab(action: UIAlertAction! = nil){
  let message = """
  Currently score is \(score)
  Tour : \(howMuchQuestion)
  Wrong Answer : \((howMuchQuestion - correct) - 1)
  Correct Answer : \(correct)
  """

  let vc = UIAlertController(title: "Score", message: message, preferredStyle: .alert)
  vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
  present(vc,animated: true)
}
```

## Result

<div>
<img src="https://user-images.githubusercontent.com/74152011/150637687-be35529e-5eee-47af-b6ca-a872836b2f43.png" width=220> 
<img src="https://user-images.githubusercontent.com/74152011/150637695-a1ffdf43-8152-4437-80e4-b8db935bf43f.png" width=220>
<img src="https://user-images.githubusercontent.com/74152011/150637688-11ebc774-32f1-46f1-bae8-9997fbdc18dd.png" width=220>
<img src="https://user-images.githubusercontent.com/74152011/150637691-f484e201-c1d9-4c1c-b7b0-3df4587e87c7.png" width=220>
</div>

