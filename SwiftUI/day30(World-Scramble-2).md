# Day 30 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/SwiftUI/Projects/World%20Scramble/World%20Scramble"> Project </a>

## SwiftUI Lists - withAnimation - Errors - on<Funcs>

## Subjects
  
+ Adding to a list of words
+ Running code when our app launches
+ Validating words with UITextChecker
  
## Summary
I'm aware that I am not able to do a lot of documents these days. That's why I end the day with a few pieces of code. I will recover soon.
  
```swift
.onSubmit(addNewWord)
.onAppear(perform: startGame)
```
```swift
guard isOriginal(word: answer) else {
    wordError(title: "Word used already", message: "Be more original")
    return
}
```
```swift
withAnimation {
    usedWords.insert(answer, at: 0)
}
```
```swift
func startGame() {
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
        if let startWords = try? String(contentsOf: startWordsURL) {
            let allWords = startWords.components(separatedBy: "\n")
            rootWord = allWords.randomElement() ?? "silkworm"
            return
        }
    }
    fatalError("Could not load start.txt from bundle.")
}
```
