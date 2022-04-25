# Day 31 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/SwiftUI/Projects/World%20Scramble/World%20Scramble"> Project </a>

## Challenges

+ Disallow answers that are shorter than three letters or are just our start word.
+ Add a toolbar button that calls startGame(), so users can restart with a new word whenever they want to.
+ Put a text view somewhere so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.

## Super Good Note 
Helloo! I came back and felt the need to make a good document. Let's complete our challenges with a great document.

### Disallow answers that are shorter than three letters or are just our start word.
```swift
func isShort(word: String) -> Bool{
    return word.count > 3
}

func isSame(word: String) -> Bool{
    return word != rootWord
}
```
Let's create 2 methods. If we combine these methods for shortness and originality control with guard, we get a great result.
```swift
guard isShort(word: answer) else {
    wordError(title: "Word not long enough", message: "You should try entering longer texts")
    return
}

guard isSame(word: answer) else {
    wordError(title: "Word not original", message: "Be original")
    return
}
```
Wonderful. We now have a system where our user can receive warnings and play according to the rules.

## Add a toolbar button that calls startGame(), so users can restart with a new word whenever they want to.
Remember toolbar again. Let's customize and place our function.
```swift
ToolbarItem(placement: .navigationBarTrailing) {
    Button {
        resetGame()
    } label: {
        Image(systemName: "arrow.counterclockwise")
    }
}
```
```swift
func resetGame(){
    usedWords.removeAll()
    newWord = ""
    startGame()
}
```
We must evaluate the possibilities at hand. Isn't every restart actually a start?

## Put a text view somewhere so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.

It's a free part. Let's set up a scoreboard first. I will use the toolbar for this again.`
```swift
@State private var score = 0

ToolbarItem(placement: .navigationBarLeading) {
    Text("Score: \(score)")
}
```

```swift
withAnimation {
    usedWords.insert(answer, at: 0)
    calculateScore(answer: answer) // here is new codes
}

func calculateScore(answer: String){
    score += (usedWords.count + answer.count)
}
```
New words created by the user for each word and their lengths are taken into account. My game, My rules!
