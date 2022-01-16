# Day 16 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day16-18"> Project </a>

## Begin to the iOS

## Subjects

+ Project Setup for UIKit 
+ FileManager and Content Connections
+ User Interface Design with Storyboard

## FileManager

A piece of code that tells where the contents are, although I find it very interesting
```swift
let fm = FileManager.default
let path = Bundle.main.resourcePath!
let items = try! fm.contentsOfDirectory(atPath: path)
```
Of course, we must find the truth of these contents and transfer them to our collection list.
```swift
var pictures = [String]()
```
```swift
for item in items {
    if item.hasPrefix("nssl") {
        pictures.append(item)
    }
}
```

## User Interface Design

<code>class ViewController: UIViewController</code> -> <code>class ViewController: UITableViewController</code>

```swift
// We say how many rows the UIViewTableController we created on the Storyboard has.
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
}

// Here, we create the text of the cells and send our cells to our table. And we do this by row index.
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
}
```

## Result

<img src="https://user-images.githubusercontent.com/74152011/149656116-b9239ace-efae-494c-8514-94dac0f9805f.png" width=355> 
