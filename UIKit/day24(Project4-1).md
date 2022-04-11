# Day 24 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day24-26"> Project </a>

## Developing on WebKit

## Subjects

+ Set-Up
+ Creating a simple browser with WKWebView
+ Choosing a website: UIAlertController action sheets

## Creating a simple browser with WKWebView

```swift
import WebKit 

var webView : WKWebView! // Create any webView

override func loadView() {
    webView = WKWebView() // sync webView to WKWebView Object
    webView.navigationDelegate = self // Add the navigation Delegate
    view = webView // Sync view to created webView
}
```
```swift 
let url = URL(string: "https://www.apple.com")! // Create any url for our page
webView.load(URLRequest(url: url)) // Request from webView that page with using this URL
webView.allowsBackForwardNavigationGestures = true // Add special iOS properties for webView (ex. RightDrag for previous page)
```

## Choosing a website: UIAlertController action sheets

```swift
// Add a rightButton on your navigation bar
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTab))

@objc func openTab(){
  let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet) // Create a AlertController

  ac.addAction(UIAlertAction(title: "github.com", style: .default, handler: openPage)) // Add some action for page open(looks like button)
  ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage)) // Add some action for page open(looks like button)
  ac.addAction(UIAlertAction(title: "Cancel", style: .cancel)) // Add a action for cancel this alertController

  ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // Bind this contoller to navigationRightBarButton

  present(ac,animated: true) // Say my alertController ready for use to Swift
}
```
```swift
func openPage(action : UIAlertAction! = nil){ // Create a function for AlertActions
    guard let actionTitle = action.title else {return} // If action title is avaiable, use this title
    guard let url = URL(string: "https://" + actionTitle) else{return} // If url is avaiable, use this URL
    webView.load(URLRequest(url: url)) // Again request from webView that page with using this URL
}

func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { // If webView load didFinished
    title = webView.title // Set navigation title to webSite title
}
```
