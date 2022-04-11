# Day 34 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day33-35"> Project </a>

## Developing on Json Data

## Subjects

+ Rendering a petition: loadHTMLString
+ Finishing touches: didFinishLaunchingWithOptions

## Rendering a petition: loadHTMLString
```swift
import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
```

## Finishing touches: didFinishLaunchingWithOptions


```swift
    let urlString: String
    
    if navigationController?.tabBarItem.tag == 0 {
        urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
    } else {
        urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
    }

    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
        }
    }

    showError()
}

func showError() {
    let ac = UIAlertController(title: "Loading error", message: "Please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```

```swift
var window: UIWindow?

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    if let tabBarController = window?.rootViewController as? UITabBarController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        tabBarController.viewControllers?.append(vc)
    }

    return true
}
```
