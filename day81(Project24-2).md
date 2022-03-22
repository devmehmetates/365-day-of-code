# Day 81 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day80-81.playground"> Project </a>

## Developing on Extensions

## Subjects

+ Wrap Up
+ Challenges

## Challenges

+ Create a String extension that adds a withPrefix() method. If the string already contains the prefix it should return itself; if it doesn’t contain the prefix, it should return itself with the prefix added. For example: "pet".withPrefix("car") should return “carpet”.
+ Create a String extension that adds an isNumeric property that returns true if the string holds any sort of number. Tip: creating a Double from a String is a failable initializer.
+ Create a String extension that adds a lines property that returns an array of all the lines in a string. So, “this\nis\na\ntest” should return an array with four elements.

## Create a String extension that adds a withPrefix() method. If the string already contains the prefix it should return itself; if it doesn’t contain the prefix, it should return itself with the prefix added. For example: "pet".withPrefix("car") should return “carpet”.
Welcome to the very, very simple yet instructive extension challenges. Let's start with the first.

```swift
// MARK: CHALLENGE 1
extension String{
    func withPrefix(_ prefix: String) -> String{
        if self.contains(prefix){
            return self
        }else{
            return prefix + self
        }
    }
}

var myExample = "pet"
myExample.withPrefix("car") // carpet
```
It's a confusing question isn't it? But its solution is nothing but string aggregation.

## Create a String extension that adds an isNumeric property that returns true if the string holds any sort of number. Tip: creating a Double from a String is a failable initializer.
```swift
// MARK: CHALLENGE 2
extension String{
    func isContainNumeric() -> Bool{
        for letter in self{
            if letter.isNumber{
                return true
            }
        }
        return false
    }
}

var myString = "aaa1aaaaa"
myString.isContainNumeric()
```
There is already a feature written for us. If we use it and have it checked for each letter, won't we get what we want? We also made it possible to exit before the for loop by using return inside :)

## Create a String extension that adds a lines property that returns an array of all the lines in a string. So, “this\nis\na\ntest” should return an array with four elements.

```swift
// MARK: CHALLENGE 3
extension String{
    func takeLines() -> Array<String>{
        var array = [String]()
        for word in self.split(separator: "\n"){
            array.append(String(word))
        }
        return array
    }
}

var myMultiLineText = "this\nis\na\ntest"
print(myMultiLineText.takeLines())
``` 
Probably a better solution will come to mind when I look a few more times. But for now this is the best solution I can think of. We divide the text from the line escape character and obtain strings. then we convert it to string one by one and convert it to the other.


## Happiness at Apple

<img src="https://applemagazine.com/wp-content/uploads/2021/03/e1a75d9ce16241ab960a1e84ed70eeed.gif" width="350" height="200"/>


