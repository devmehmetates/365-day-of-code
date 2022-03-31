# Day 90 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day90/Day90"> Project </a>

## Develop a Meme Creator

## Subjects

+ Wrap Up
+ Challenges

## Challenges
+ Prompt the user to import a photo from their photo library.
+ Show an alert with a text field asking them to insert a line of text for the top of the meme.
+ Show a second alert for the bottom of the meme.
+ Render their image plus both pieces of text into one finished UIImage using Core Graphics.
+ Let them share that result using UIActivityViewController.

## Summary
Hello. Today's challenge is to make a meme creator. I made a meme creator that provides all the desired features but even more features. But instead of alerts, I used UISwitches and Textfields. This gave me the chance to add the preview feature. Yes, before I start looking at the project, let me state that I will not be doing a code review today. Now let's see how it would have been if we had done it as desired.
```swift
let ac = UIAlertController(title: "Enter up text!", message: nil, preferredStyle: .alert)
ac.addTextField()

ac.addAction(UIAlertAction(title: "submit", style: .default, handler: { [weak self, weak ac] _ in
    guard let field = ac?.textFields?[0].text else { return }
    // set this value to any page variable. after, use it on drawImage func
}))

present(ac, animated: true)
```
This is exactly how we would do it. And now let's share useful codes and end the day.

## Useful Codes
```swift
upTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)

@objc func textChanged(_ textField: UITextField){
   drawImage()
}
```

```swift
imageView.image?.draw(at: CGPoint(x: 0, y: 0))
```

```swift
@IBAction func upTextToggle(_ sender: UISwitch) {

    upTextField.isEnabled = sender.isOn

    if !sender.isOn{
        upTextField.text = ""
        drawImage()
    }

}
```



## Happiness at Apple

<img src="https://applemagazine.com/wp-content/uploads/2021/03/e1a75d9ce16241ab960a1e84ed70eeed.gif" width="350" height="200"/>


