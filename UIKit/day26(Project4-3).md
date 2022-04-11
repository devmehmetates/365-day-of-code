# Day 26 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day24-26"> Project </a>

## Developing on WebKit

## Subjects

+ Wrap Up
+ Challenge

## Challenge

### If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked.

```swift
// Create an alert dialog
let wac = UIAlertController(title: "Unallowed Url", message: "Please try another url", preferredStyle: .alert)
wac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
```
```swift
if let host = url?.host{
    var control = false // Check your web site for alert 
    for webSite in webSites {
        if host.contains(webSite){
            decisionHandler(.allow)
            control = true // If your web site was allowed set control to true
            return
        }
    }
    if !control{ If your web site wasn't allowed
        present(wac, animated: true, completion: nil) // Show your alert on screen
    }
}
```

### Try making two new toolbar items with the titles Back and Forward. You should make them use webView.goBack and webView.goForward.
```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTab))
        
// Create two buttons for go forward or backward
let forwardAndBackButtons = [
    UIBarButtonItem(image:  UIImage(systemName: "arrow.forward"), style: .done, target: self,action: #selector(forwFunc)),
    UIBarButtonItem(image:  UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(backFunc)),
]

navigationItem.rightBarButtonItems = forwardAndBackButtons // Set rightbarbuttons to your buttons
```
And create your button functions with use webView.goBack() or webView.goForward()

```swift
@objc func backFunc(){
  let bfac = UIAlertController(title: "Process failed", message: "You can't forward or backward for now", preferredStyle: .alert)
  bfac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

  if webView.canGoBack{ // If you can go back
      webView.goBack() // Go back
  }else{
      present(bfac, animated: true, completion: nil)
  }
}
```
```swift
@objc func forwFunc(){
    let bfac = UIAlertController(title: "Process failed", message: "You can't forward or backward for now", preferredStyle: .alert)
    bfac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

    if webView.canGoForward{ // If you can go forward
        webView.goForward() // Go forward
    }else{
        present(bfac, animated: true, completion: nil)
    }
}
```

### For more of a challenge, try changing the initial view controller to a table view like in project 1, where users can choose their website from a list rather than just having the first in the array loaded up front.

```swift
class InitPageTableViewController: UITableViewController {

    let webSites = ["apple.com", "github.com","twitter.com"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webSites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Page", for: indexPath)
        cell.textLabel?.text = webSites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebTitle") as? ViewController{
            vc.webSites = webSites
            vc.selectedSite = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }else{
            print("false")
        }
    }

}
```

## Result

<div>
  <img src="https://user-images.githubusercontent.com/74152011/151203598-df9cbc63-5d3d-41b6-9b6d-9084dc51e443.png" width=220>
  <img src="https://user-images.githubusercontent.com/74152011/151203608-5be46da5-905e-4440-822d-06c5d61583b1.png" width=220>
  <img src="https://user-images.githubusercontent.com/74152011/151203627-6f60c625-e8f1-49e0-aa96-4f52ecb9433c.png" width=220>
  <img src="https://user-images.githubusercontent.com/74152011/151203673-e2926407-03d0-41e1-a583-25e300d8e8f0.png" width=220>
  <img src="https://user-images.githubusercontent.com/74152011/151203645-a66297af-dedd-429b-a73f-8e9e24aa5575.png" width=220>
  <img src="https://user-images.githubusercontent.com/74152011/151203655-438f3a2f-068c-484d-95b6-232f13bd6101.png" width=220>
</div>
