# Day 67 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day67-69/Day67-69"> Project </a>

## Developing on Apps Extension

## Subjects

+ Set-Up
+ Making a shell app
+ Adding an extension: NSExtensionItem
+ What do you want to get?

### Making a shell app
We do almost nothing in this section. Just throwing one UILabel in main.storyboard.

## Adding an extension: NSExtensionItem
Let's add an extension to the application. This is something completely new. We do this by adding a target. And a new folder is created for our application.
```swift
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    // do stuff!
                }
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
```
We see an edited version of the file it contains. Of course, we made some changes in info.plist after that. Strange and new.

## What do you want to get?
```js
var Action = function() {};

Action.prototype = {

  run: function(parameters) {

  },

  finalize: function(parameters) {

  }

};

var ExtensionPreprocessingJS = new Action
```
We want to run JavaScript codes, known as the muscle system of websites. We have a js file. And it works to perform the written operations. But for now we can't do anything.

## Happy Coding :)
Yes, so we finished the day. It's really good day for me. Great coding to all.

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

