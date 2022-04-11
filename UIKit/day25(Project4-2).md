# Day 25 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day24-26"> Project </a>

## Developing on WebKit

## Subjects

+ Monitoring page loads: UIToolbar and UIProgressView
+ Refactoring for the win

## Monitoring page loads: UIToolbar and UIProgressView

```swift
let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // Create flexible space to toolbar
let reflesh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload)) // Create reflesh button to toolbar
```

```swift 
var progressView : UIProgressView! // Create an progressView

progressView = UIProgressView(progressViewStyle: .default) // set the progressview by default
progressView.sizeToFit() // fit progress view size
let progressButton = UIBarButtonItem(customView: progressView) // Create progress button to toolBar
```
```swift
toolbarItems = [progressButton, spacer, reflesh] // Add created button to toolbar
navigationController?.isToolbarHidden = false // Set toolbar hidden properties to never hidden
```

```swift
webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) // Create an observer object for page loading state

override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress"{ // Sync key to estimated time key string for web site
        progressView.progress = Float(webView.estimatedProgress) // set progress view value to estimated time
    }
}
```

## Refactoring for the win

```swift
let webSites = ["apple.com", "github.com"] // create a list for safe

let url = URL(string: "https://" + webSites[0])! // set first link for default web site
 
for webSite in webSites {
    ac.addAction(UIAlertAction(title: webSite, style: .default, handler: openPage)) // Don't copy any code, Use "for" for repeated functionalaty
}
```

```swift
func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
  let url = navigationAction.request.url

  if let host = url?.host{
      for webSite in webSites {
          if host.contains(webSite){ // Check the url is contains to our list
              decisionHandler(.allow) // If this url contains on our list, allow for open
              return
          }
      }
  }
  decisionHandler(.cancel) // If this url not contains on our list, decline for open. 
}
```

<div>
  <img src="https://user-images.githubusercontent.com/74152011/151007811-fe7c850a-50fc-4b78-8c2f-83c3668e132e.png" width=280>
  <img src="https://user-images.githubusercontent.com/74152011/151007900-4b9e3038-4244-406f-b90a-0e0031ad464c.png" width=280>
  <img src="https://user-images.githubusercontent.com/74152011/151007914-46f5679f-3fa8-4896-a052-4d3356298d1f.png" width=280>
</div>
