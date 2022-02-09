# Day 40 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day16-18"> Project-1 </a> <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day36-38"> Project-2 </a> <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day33-35"> Project-3 </a>

## Let's use Async

## Subjects

+ Wrap Up
+ Challenges

## Challenges
Today we have 3 projects that we will convert some parts to async. Let's start with our first project.

### Project-1
We learned the easy way to run it in the background. So let's use

```swift
@objc func getPhotos(){
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)

    for item in items {
        if item.hasPrefix("nssl") {
            pictures.append(item)
        }

    }
    pictures.sort()
    DispatchQueue.main.async {
        self.tableView.reloadData()
    }
}
```

```swift
...
performSelector(inBackground: #selector(self.getPhotos), with: nil)
...
```
That's all. Our data comes in the background. And after it arrives our main thread is updating our tableView.

### Project-2

```swift
@objc func loadLevel(){
    DispatchQueue.main.async {
        var cluesString = ""
        var solutionString = ""
        var letterBits = [String]()

        if let levelFileURL = Bundle.main.url(forResource: "level\(self.level)", withExtension: "txt"){
            if let levelContent = try? String(contentsOf:levelFileURL){
                var lines = levelContent.components(separatedBy: "\n")
                lines.shuffle()

                for (index,line) in lines.enumerated(){
                    let parts = line.components(separatedBy: ":")
                    let answer = parts[0]
                    let clue = parts[1]

                    cluesString += "\(index + 1). \(clue)\n"
                    let solutionsWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionsWord.count) letters \n"
                    self.solutions.append(solutionsWord)

                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }

            }
        }

        self.cluesLabel.text = cluesString.trimmingCharacters(in: .whitespacesAndNewlines)
        self.answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

        self.letterButtons.shuffle()

        if self.letterButtons.count == letterBits.count{
            for i in 0..<self.letterButtons.count{
                self.letterButtons[i].setTitle(letterBits[i], for: .normal)

            }
        }
    }
}
```

```swift
...
performSelector(inBackground: #selector(self.loadLevel), with: nil)
...
```
Here our process is happening in the background. But every data loaded must be updated on our page. So it has to be async. If you want, remove the main workpiece. You will see that the data of the application is not loaded.

### Project-3

```swift
func searchWord(_ keys : [String]){
    DispatchQueue.global(qos: .userInitiated).async {
        if !self.mainPetitions.isEmpty{
            self.petitions = self.mainPetitions
        }
        var changePetition = [Petition]()
        for petition in self.petitions {
            if petition.body.lowercased().contains(keys[0].lowercased()){
                changePetition.append(petition)
            }
        }
        self.mainPetitions = self.petitions
        self.petitions = changePetition
    }
    DispatchQueue.main.async {
        self.tableView.reloadData()
    }
}
```
We can't use perform here. Because this function is triggered by a button. Already in a selector. So let's use the other background process we learned.But our table should be updated on our home page. Otherwise, your data may be lost or our application may crash. So let's update it after processing is done on the main thread.


## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">










