# Day 27 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day27-29"> Project </a>

##  Weak Strong and Unowned references - Disk processs

###  What is Weak Strong and Unowned references?
In fact, this is a very complex subject that takes time to understand. That's why I want to explain as short as possible and only touch on important points.

### Strong
```swift
class Singer {
    func playSong() {
        print("you broke me first")
    }
}

func sing () -> () -> Void {
    let tateMcrae = Singer()
    
    let singing = {
        tateMcrae.playSong()
        return
    }
    
    return singing
}

let singSong = sing()
singSong()
```
In this example, we have a simple class and a function that returns a closure. We have no definitions here. That's why our reference is strong by default.
This means that as long as the closure exists, our created reference will also exist and not be destroyed. 

### Weak

```swift
func sing () -> () -> Void {
    let tateMcrae = Singer()
    
    let singing = { [weak tateMcrae] in
        tateMcrae?.playSong()
        return
    }
    
    return singing
}
```
Now let's update our function above. Now our reference is weak and allowed to be destroyed. Therefore, our song will not be printed, as in the strong reference. So "tatemcrae" in our code is now nil. <br>

If you make <code>tateMcrae?.playSong()</code> to <code>tateMcrae!.playSong()</code> now your code will crash. Because you are trying to use a nil value.


### Unowned

```swift
func sing () -> () -> Void {
    let tateMcrae = Singer()
    
    let singing = { [unowned tateMcrae] in
        tateMcrae.playSong()
        return
    }
    
    return singing
}
```

If we update our reference to unowned, our code will not work at all. Because here our reference was destroyed as soon as the closing was over. But we said it would never perish. This is why unowned references are so dangerous.

### Problems

This part is really hard to understand and you definitely need to try it a few times to get it. So I skip this part. <a href="https://www.hackingwithswift.com/articles/179/capture-lists-in-swift-whats-the-difference-between-weak-strong-and-unowned-references">Here</a> is the source for you to browse.

### Finally, let's see when to use it.

+ If your value is truly never lost you can use unowned.
+ If there is a loop in our references. Either one must be weak.
+ Use strong unless a reference loop is involved.

### Suggestion
I definitely recommend checking out the source. It's a really complex subject and we'll need some experience to fully understand it.


## Project 5

### Subjects

+ Reading from disk: contentsOfFile
+ Pick a word, any word: UIAlertController

## Reading from disk: contentsOfFile
Create two empty lists. Let's find the path of the file and read it line by line. Then let's add the words to the "allwords" array one by one. If we have a problem let's add a single word.
```swift
var allWords = [String]()
var usedWords = [String]()

if let startUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
    if let startWords = try? String(contentsOf: startUrl){
        allWords = startWords.components(separatedBy: "\n")
    }
}

if allWords.isEmpty{
    allWords = ["Mehmet"]
}

```

Equate the page title to a random word. eemove all used words and update the table.
```swift
func startGame(){
    title = allWords.randomElement()
    usedWords.removeAll(keepingCapacity: true)
    tableView.reloadData()
}

startGame()
```

Let's create the cell count and cells in our table.
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
}
```

## Pick a word, any word: UIAlertController
Let's add the add button to our navigation bar
```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
```
### Important Section ⚠️

It's really not that hard to understand. A simple alert action as usual. One difference, but one very important difference. A closure and weak references are used in that closure. As far as I understand, the reason for using weak reference here is that we use a repeated ac and if we keep it in memory we will not get our new word. So our closure will always exist because of the button. And we create it as a weak reference and make it disappear as soon as your alert is turned off.

```swift
@objc func promptForAnswer() {
    let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
    ac.addTextField()

    let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
        guard let answer = ac?.textFields?[0].text else { return }
        self?.submit(answer)
    }

    ac.addAction(submitAction)
    present(ac, animated: true)
}

func submit(_ answer: String) {
}
```

# 🤯
