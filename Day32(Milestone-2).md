# Day 32 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day32-Challenge"> Project </a>

##  WebKit - AutoLayout - And some new UI objects

## Subjects

+ Challenge

## Challenges
I open today's challenge completely to you. Let's move step by step.

### Create an table view controller
There are 2 ways to do this
+ Create a new file with a cocoa touch class
+ Or edit your existing viewcontroller file
I've dealt with item 2 here.
```swift
class ViewController: UITableViewController
```
Of course, we should also do the following.
+ Delete the viewcontroller in main.storyboard file
+ Create a new table view controller
+ Update cell name to "Matter"
+ Then embed the table view controller in the navigation view
+ Finally connect table view controller with viewcontroller file

### Create an shoplist and add items
I'm listing the things we need to be able to do that. I will add them one by one later.
+ A navigationItem
+ A UIBarButtonItem
+ A obcj func
+ A UIAlertController
+ A UIAlertAction
+ A addTextField

That's it, let's create it now. I also add the clause at the beginning of each file.

```swift
// navigationItem and UIBarButtonItem
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMatter))
```

```swift
// Table view editting
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shoppingList.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Matter", for: indexPath)
    cell.textLabel?.text = shoppingList[indexPath.row]
    return cell
}
```

```swift
// obcj func, UIAlertController, UIAlertAction, addTextField
@objc func addMatter(){
    let ac = UIAlertController(title: "Add an matter", message: nil, preferredStyle: .alert)
    ac.addTextField()
    let addAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
        guard let matter = ac?.textFields?[0].text else { return }
        self?.createMatter(matter)
    }
    ac.addAction(addAction)

    present(ac,animated: true)
}
```

### Clean our shopping list 
In this section, I wanted to edit our buttons a little and ask if you are sure. So here's a little extra. 
```swift
// Buttons edit
let rightItems = [UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cleanList)), UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMatter))]      
navigationItem.rightBarButtonItems = rightItems
```

In this section, if you want, you can do the operations here without using the other function.You can even raise a warning when the list is cleared if you want to take it even further. You can do this in delete Items.
```swift
@objc func cleanList(){
    let dac = UIAlertController(title: "Are you sure?", message: "This process cannot be undone", preferredStyle: .alert)
    dac.addAction(UIAlertAction(title: "Delete", style: .default, handler: deleteItems))
    dac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    present(dac,animated: true)
}

func deleteItems(action: UIAlertAction? = nil){
    self.shoppingList.removeAll()
    tableView.reloadData()
}
```

### Share your list
We need a UIActivityViewController for this.
```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))

@objc func shareList(){
    let list = shoppingList.joined(separator: "\n")
    let actvc = UIActivityViewController(activityItems: [list], applicationActivities: [])
    actvc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem

    present(actvc,animated: true)
}
```

## Summary
Here we have successfully completed this challenge. I got help from my old projects, or rather, these documents I prepared.And thereby, I completed it incredibly fast. Also available in the project in the title. If you are confused, please have a look there as well. Clone it if you want. This is yours.


## Great Work :)

<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="500" height="300"/>

