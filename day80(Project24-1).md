# Day 80 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day80-81.playground"> Project </a>

## Developing on Extensions

## Subjects
+ Setting up
+ Strings are not arrays
+ Working with strings in Swift
+ Formatting strings with NSAttributedString

## Strings are not arrays
Since we can return strings with for in Swift, they can look like arrays. But when we try to get data from them with an index, unfortunately we fail. As in the title, strings are not arrays.

```swift
let name = "Mehmet"

for letter in name{
    print(letter)
}

// print(name[2]) this code not working
```
Non-command code works really well. But that code creates a big problem for us. What if we told you that we can fix this problem?

```swift
let secondLetter = name[name.index(name.startIndex, offsetBy: 2)]

print(secondLetter)
```
Now we have to get to the bottom of the matter. Yes this code may not look the same. But it definitely works perfectly. Start from the beginning give me the element when I get to the 2nd index. Now let's write a extension and display it the way we want.

```swift
extension String{
    subscript(i: Int) -> String{
        return String(self[index(startIndex, offsetBy: i)])
    }
}

print(name[0])
```
Here it is. We methodized the same work and made it the way we wanted.

##  Working with strings in Swift
We can write extensions. So, can we do something about existing extensions?

```swift
let password = "12345"
print(password.hasPrefix("123"))
print(password.hasSuffix("345"))


extension String{
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}


print(password.deletingPrefix("12"))
```
For example, an extension that deletes those lines if there are actually lines we have entered? There are a few more examples like this on hacking with swift. Paul really thought of everything :)

## Formatting strings with NSAttributedString
This part was really fun. Because you can do really cool things. Your imagination and Swift abilities guide you.
```swift
let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]
```
It has an ugly use in this way. But there is also a surprise.

```swift
let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
```
I think it is much more comfortable to do this in 2 parts. And you're really in a position to do anything you can think of. Hey! Of course it's about the strings. Try it and see.

## Happy Coding :)
<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

