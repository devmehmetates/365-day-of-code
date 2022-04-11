# Day 69 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day67-69/Day67-69"> Project </a>

## Developing on App Extensions

## Subjects

+ Wrap Up
+ Challenges

## Challenges

+ Add a bar button item that lets users select from a handful of prewritten example scripts, shown using a UIAlertController – at the very least your list should include the example we used in this project.
+ You're already receiving the URL of the site the user is on, so use UserDefaults to save the user's JavaScript for each site. You should convert the URL to a URL object in order to use its host property.
+ For something bigger, let users name their scripts, then select one to load using a UITableView.


##  Add a bar button item that lets users select from a handful of prewritten example scripts, shown using a UIAlertController – at the very least your list should include the example we used in this project.
Yes, let's start with the first of the challenges. 
```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(selectCode))
```

```swift
@objc func selectCode(){
    let ac = UIAlertController(title: "Select Any Code", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "Alert Template", style: .default, handler: selectCodeAction))
    ac.addAction(UIAlertAction(title: "Calculate Total", style: .default, handler: selectCodeAction))

    present(ac, animated: true)
}

func selectCodeAction(action: UIAlertAction? = nil){
    guard let title = action?.title else{ return }
    if title == "Alert Template"{
        self.script.text = "alert();"
    }else{
        self.script.text = """
        // write any process in alert code
        // example alert(3 + 7); -> 10
        alert();
        """
    }

```
Now this difficulty is one that we can easily explain. As usual, we put a button and open the action sheet. So there's really nothing special about it.

## You're already receiving the URL of the site the user is on, so use UserDefaults to save the user's JavaScript for each site. You should convert the URL to a URL object in order to use its host property.
Here we go! 

```swift
let defaults = UserDefaults.standard
...


let leftButton1 = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(selectCode))
let leftButton2 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCode))

navigationItem.leftBarButtonItems = [leftButton1, leftButton2]
```

```swift
@objc func addCode(){
    var alertTitle = ""
    guard let scriptText = script.text else { return }
    if self.pageTitle != ""{
        self.defaults.set(scriptText, forKey: self.pageTitle)
        alertTitle = "Save Completed"
    }else{
        alertTitle = "Save failed"
    }
    let ac = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    present(ac,animated: true)
}
```

```swift
DispatchQueue.main.async {
    self?.title = self?.pageTitle
    
    // Add this lines
    if let pageValue = self?.defaults.object(forKey: self!.pageTitle) as? String{
        self?.script.text = pageValue
    }
}
```

It may seem like a lot, but it actually codes pretty fast. First, let's change our button structures. Next, let's write the function of the button we added later.
So what exactly does this do? What the function does is just save a value as usual. So what happens after? Now, every time we open an extension, we read and write the saved code for our page.

## For something bigger, let users name their scripts, then select one to load using a UITableView
Now I want to take the rules into my own hands. Now, let's improve this item a little bit. Yes, it will be able to save scripts with a name. And the user will be able to view them at any time. I think it is unreasonable to show this in table view. Instead, I made the action sheet and made it easier for the user.

```swift
@objc func addCode(){
    let ac = UIAlertController(title: "Add Your Code", message: nil, preferredStyle: .alert)
    ac.addTextField()

    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    ac.addAction(UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
        guard let newName = ac?.textFields?[0].text else { return }
        var alertTitle = ""
        guard let scriptText = self?.script.text else { return }
        if self?.pageTitle != ""{
            self?.userScripts[newName] = scriptText
            self?.defaults.set(self?.userScripts, forKey: self!.pageTitle)
            alertTitle = "Save Completed"
        }else{
            alertTitle = "Save failed"
        }
        let sac = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        sac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self?.present(sac,animated: true)
    })

    present(ac, animated: true)
}

```

First, we extend the code saving function we just wrote. Of course, there are also innovations that we need to do. For example where do "userScripts" come from?
Since we need to destroy the previously recorded ones, we first need to bring the old codes and then add them to it.

```swift
var userScripts = Dictionary<String, String>()
...


DispatchQueue.main.async {
    self?.title = self?.pageTitle
    if let pageValue = self?.defaults.object(forKey: self!.pageTitle) as? Dictionary<String, String>{
        self?.userScripts = pageValue

        if self?.userScripts.count != 0{
            let ac = UIAlertController(title: "You have \(self!.userScripts.count) script for this page!", message: "Please select any script for start.", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "No!", style: .cancel, handler: nil))
            self?.userScripts.forEach {
                ac.addAction(UIAlertAction(title: $0.key, style: .default, handler: self?.selectUserCode))
            }
            self?.present(ac, animated: true)
        }
    }
}
``` 

```swift
func selectUserCode(action: UIAlertAction? = nil){
    guard let title = action?.title else { return }
    if let script = self.userScripts[title]{
        self.script.text = script
    }
}
```
That's why we need to add these codes beforehand. In this way, we now have old records and we can record with naming on it. Under these conditions, the user will only be able to see these codes for the first time. This shows that we need to make one more button.

```swift
let leftButton1 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(selectCode))
let leftButton2 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCode))
let leftButton3 = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showSavedScripts))

navigationItem.leftBarButtonItems = [leftButton1, leftButton2, leftButton3]
```

```swift
@objc func showSavedScripts(){
    let ac = UIAlertController(title: "You have \(self.userScripts.count) script for this page!", message: "Select one.", preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "No!", style: .cancel, handler: nil))
    self.userScripts.forEach {
        ac.addAction(UIAlertAction(title: $0.key, style: .default, handler: self.selectUserCode))
    }
    present(ac, animated: true)
}
```

That's it. If I did this in accordance with the challenge, how would I do it? Let me explain that too.

+ It was necessary to create a table view from the storyboard. And I wouldn't name his cell.
+ In the same way, I would keep the information on my page and push it to my table view.
+ We were going to have the elements selected but this selection should only change the selection value.
+ After the selected element the save button would pop up the table view. And it would push back the selected value.
+ This would be our script value.

If the codes were also requested to be deleted, it would be more logical to do it this way.

## Great Work :)

<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="700" height="500"/>


