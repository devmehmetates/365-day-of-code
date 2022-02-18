# Day 44 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day36-38"> Project </a>

## Developing on UserDefaults, Codable

## Subjects

+ Fixing Project 10: Codable
+ Wrap Up
+ Challenges

## Fixing Project 10: Codable
```swift
class Person: NSObject, Codable {
...
```
```swift
func save() {
    let jsonEncoder = JSONEncoder()
    if let savedData = try? jsonEncoder.encode(people) {
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
    } else {
        print("Failed to save people.")
    }
}
//////////////////////

let defaults = UserDefaults.standard

if let savedPeople = defaults.object(forKey: "people") as? Data {
    let jsonDecoder = JSONDecoder()

    do {
        people = try jsonDecoder.decode([Person].self, from: savedPeople)
    } catch {
        print("Failed to load people")
    }
}
```
We convert the person object to JSON and write it with the codable protocol, which is more comfortable in terms of use. Then we decode it from the JSON and read it.



## Challenges

+ Modify project 1 so that it remembers how many times each storm image was shown – you don’t need to show it anywhere, but you’re welcome to try modifying your original copy of project 1 to show the view count as a subtitle below each image name in the table view.
+ Modify project 2 so that it saves the player’s highest score, and shows a special message if their new score beat the previous high score.
+ Modify project 5 so that it saves the current word and all the player’s entries to UserDefaults, then loads them back when the app launches.

### Modify project 1 so that it remembers how many times each storm image was shown – you don’t need to show it anywhere, but you’re welcome to try modifying your original copy of project 1 to show the view count as a subtitle below each image name in the table view.
```swift
let defaults = UserDefaults.standard

/////
for picture in pictures{
    picturesShowCount.append(defaults.object(forKey: picture) as? Int ?? 0)
}

/////
let showingCount = defaults.object(forKey: pictures[indexPath.row]) as? Int ?? 0
cell.detailTextLabel?.text = String(showingCount)

/////
defaults.set(picturesShowCount[indexPath.row] + 1, forKey: pictures[indexPath.row])
picturesShowCount[indexPath.row] = picturesShowCount[indexPath.row] + 1
```
A very simple piece.
+ Create a count list of readed pictures. if there is a record take that number otherwise write 0
+ Take the number of reads of the picture from this list and show it in the table as subtitle.
+ When going to view the picture save our new record and increase the value in the list by 1

### Modify project 2 so that it saves the player’s highest score, and shows a special message if their new score beat the previous high score.
```swift
let defaults = UserDefaults.standard
var highScoreSetted = false

/////
let highScore = defaults.object(forKey: "highScore") as? Int ?? 0

/////
let hc = UIAlertController(title: "High Score!", message: "You reach a new high score\n ⭐️", preferredStyle: .alert)
hc.addAction(UIAlertAction(title: "Thanks😎", style: .default, handler: askQuestion))

if highScore != 0 && score > highScore && !highScoreSetted{
    present(hc,animated: true)
    highScoreSetted = true
}

/////
if howMuchQuestion == 10{
    if score > highScore{
        defaults.set(score, forKey: "highScore")
    }
```

Likewise, many piece.
+ Take a highscore value or take it as 0.
+ Show alert if score is not 0 and no highscore has been set throughout the game.

### Modify project 5 so that it saves the current word and all the player’s entries to UserDefaults, then loads them back when the app launches.
```swift
let defaults = UserDefaults.standard

/////
@objc func resetGame(){
    let newWorld = allWords.randomElement()
    DispatchQueue.main.async {
        self.defaults.set(newWorld, forKey: "currentWord")
        self.defaults.set([String](), forKey: "usedWords")
        self.startGame()
    }  
}

/////
func startGame(){
    if let currentTitle = defaults.object(forKey: "currentWord") as? String{
        title = currentTitle
    }else{
        title = allWords.randomElement()
        defaults.set(title, forKey: "currentWord")
    }
    if let savedUsedWords = defaults.object(forKey: "usedWords") as? [String]{
        usedWords = savedUsedWords
    }
    tableView.reloadData()
}

/////
DispatchQueue.main.async {
    self.defaults.set(self.usedWords, forKey: "usedWords")
}
```
Let's examine it again
+ If there is no title record, set random word and assign it as title
+ Do the same for used words.
+ Update the words used every time a word is added

When the game is reset
+ Set a new word and save it
+ Clear used words and save this
+ When these processes are finished, perform the above operations again with the game start function.


## Every code has a meaning :)

<img src="https://i.giphy.com/media/zOSrTdd3xPRYTqy54P/giphy.webp">










