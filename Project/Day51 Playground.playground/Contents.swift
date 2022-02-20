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

