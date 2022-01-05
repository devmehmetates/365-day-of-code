# Day 4 

## Loops 📖
Loops are often used to perform repetitive operations.

## Usage 🔨

### For Loops
```swift
// You can use it with the range we processed earlier.
let count = 0...3

for num in count{
  print("Count : \(num)") // Count : 0 / Count : 1 / Count : 2 / Count : 3
}
// Same way is valid for arrays
let days = ["Monday" , "Tuesday", "Wednesday"]

for day in days{
  print("Day : \(day)") // Day : Monday / Day : Tuesday / Day : Wednesday
}
```

### While Loops
```swift
// Loops that run based on a condition.
var lvl = 1

while lvl <= 9 {
  print("You need more levels") // This output is printed on the screen 9 times
  lvl += 1
}
print("Congratulations! You are \(lvl) lvl") // Congratulations! You are 10 level
```

### Repeat Loops
```swift
// It always runs once and then performs the check.
var lvl = 1
repeat {
   print("You need more levels") // This output is printed on the screen 9 times
  lvl += 1
} while lvl <= 9
print("Congratulations! You are \(lvl) lvl") // Congratulations! You are 10 level

// It may seem like there is no difference
repeat{
  print("Look") // This output was printed.
} while false

while false{
  print("Look") // But this output was not printed.
}
```

### Exiting Loops
```swift
// If your loop job ends early
var num = 0
while true{
  print("This loop is actually endless. Until i say stop") // This output is printed on the screen 5 times
  if num == 4{
    print("The end.")
    break
  }
  num += 1
}
```

### Exiting Multiple Loops
```swift
// If your loop runs out early and you are using multiple loops
outerLoop: for i in 1...5 {
    for j in 1...5{
        let multiply = i * j
        print("result : \(multiply)")
        if multiply == 15 {
            print("Let's break")
            break outerLoop
        }
    }
}
// Thus, you have prevented many unnecessary operations from being performed.
```

### Skipping in Loops
```swift
// With this, you don't run the code for the rest of the loop.
for i in 0...10{
  if i % 2 == 0{
    continue
  }
  print(i) // 1 3 5 7 9 
} 
// As can be seen, the number is not printed when dividing by 2
```

### Infinite Loops
```swift
// That loops running forever
var count = 0
while true{
  print("I'm infinite")
  count += 1
  if count == 10{
    print("No, you are broken")
    break
  }
}
```

## Tips 🤔💭
I wanted to avoid too much complexity as most of the hints are related to its use. So hints are hidden in usages.

### For Loops
```swift
// If you just want the code to work
let count = 0...4

for _ in count{ // _ prevents empty variable assignment. So Swift is fast and smart.
  print("Repeat Me 5 times") // This output is printed on the screen 5 times
}
```

