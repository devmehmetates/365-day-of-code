# Day 68 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day67-69/Day67-69"> Project </a>

## Developing on Apps Extension

## Subjects

+ Establishing communication
+ Editing multiline text with UITextView
+ Fixing the keyboard: NotificationCenter

## Establishing communication
```js
run: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title });
},
```

This code does exactly that. It executes the above java script code when our extension runs. Because we do this on viewDidLoad.
```swift
guard let itemDictionary = dict as? NSDictionary else { return }
guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
print(javaScriptValues)
```

As a result, we see the following output.
```console
{
    URL = "https://www.apple.com/tr";
    title = "Apple (Türkiye);
}
```

## Editing multiline text with UITextView

```swift
var pageTitle = ""
var pageURL = ""
.
.
.

self?.pageTitle = javaScriptValues["title"] as? String ?? ""
self?.pageURL = javaScriptValues["URL"] as? String ?? ""

DispatchQueue.main.async {
    self?.title = self?.pageTitle
}
```
Now let's write this instead of print. We have now processed the data we have just obtained on our page. Perfect!

```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
```

```swift
@IBAction func done() {
    let item = NSExtensionItem()
    let argument: NSDictionary = ["customJavaScript": script.text]
    let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
    let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
    item.attachments = [customJavaScript]

    extensionContext?.completeRequest(returningItems: [item])
}
```
Now, before this part, we made changes to the extension storyboard. For example here. A textview defined via storyboard in the script project. That's why. I also recommend you to review the project.

```js
finalize: function(parameters) {
    var customJavaScript = parameters["customJavaScript"];
    eval(customJavaScript);
}
```
And now we have to say When we press the Done button, run this js code. The js codes we have written now can be run on safari. Cool!

##  Fixing the keyboard: NotificationCenter
But we still have one question. We wanted to write a very long code and run it, but after a while our code will be under our keyboard and boom! This is going to turn into absolute torture. Here we are discussing an issue that I think is important.

```swift
let notificationCenter = NotificationCenter.default
notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
```
Now I will explain these two steps carefully. At the top we define a notification listener. So when there are events, it will send us a notification. But what events? You can see that there are 2 events. Notifications about keyboard hiding and changing keyboard size.

```swift
@objc func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

    if notification.name == UIResponder.keyboardWillHideNotification {
        script.contentInset = .zero
    } else {
        script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
    }

    script.scrollIndicatorInsets = script.contentInset

    let selectedRange = script.selectedRange
    script.scrollRangeToVisible(selectedRange)
}
```
Here we see the objc function they are connected to. While what we're doing here is important, it's pretty obvious. The question we're asking here is, is the keyboard hiding something? So scroll.


## Happy Coding :)
Yes, so we finished the day. It's really good day for me. Great coding to all.

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

