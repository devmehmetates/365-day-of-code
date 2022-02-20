# Day 51 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day51%20Playground.playground">Playground</a>
All code is here

```swift
import Cocoa

var myNumbers = [1,2,3,4,5]
var x3Numbers = myNumbers.map{ $0 * 3 } // [3, 6, 9, 12, 15]
var numbersToString = myNumbers.map{ String($0) } // ["1", "2", "3", "4", "5"]
var optionalNumbers = numbersToString.map { Int($0) } // [Optional(1), Optional(2), Optional(3), Optional(4), Optional(5)]
// If we want to non optional value
var nonOptionalNumbers = numbersToString.compactMap{ Int($0) } // [1, 2, 3, 4, 5]
var tryToInt = ["1", "2", "3" , "Mehmet"]
var tryWithMap = tryToInt.map{ Int($0) } // [Optional(1), Optional(2), Optional(3), nil]
var tryWithFlatMap = tryToInt.flatMap{ Int($0) } // [1, 2, 3]
var tryWithCompactMap = tryToInt.compactMap{ Int($0) } // [1, 2, 3]
```

Today's purpose was definitely more about doing the best at what you do than learning new things. The new functions I learn today will probably be things I will use a lot in the future. I can do the same job without these. But trying to do the job well and trying to be faster is absolutely necessary.

In particular, I will try to use them instead of for loops at length. Getting started is the most basic step to success!

## Fail. And then try again. Until you succeed.

Below I leave a video link that really impressed me. If the main purpose of our day is to open horizons and if we are going to do something for this purpose. This video is just for that.

<a href="https://www.youtube.com/watch?v=EiKK04Ht8QI">You should watch this</a>
