import UIKit

// MARK: First Section
let name = "Mehmet"

for letter in name{
    print(letter)
}

// print(name[2]) this code not working

let secondLetter = name[name.index(name.startIndex, offsetBy: 2)]

print(secondLetter)

extension String{
    subscript(i: Int) -> String{
        return String(self[index(startIndex, offsetBy: i)])
    }
}

print(name[0])

// MARK: Second Section

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

let weather = "it's going to rain"
print(weather.capitalized)

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}

print(weather.capitalizedFirst)

let input = "Swift is like Objective-C without the C"
input.contains("Swift")

let languages = ["Python", "Ruby", "Swift"]
languages.contains("Swift")


extension String {
    func containsAny(of array: [String]) -> Bool {
        for item in array {
            if self.contains(item) {
                return true
            }
        }
        
        return false
    }
}


input.containsAny(of: languages)

languages.contains(where: input.contains)


// MARK: Third Section

let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))

attributedString.addAttribute(.underlineStyle, value: true, range: NSRange(location: 15, length: 6))

attributedString.addAttribute(.strikethroughStyle, value: true, range: NSRange(location: 15, length: 6))

attributedString.addAttribute(.paragraphStyle, value: true, range: NSRange(location: 15, length: 6))

attributedString.addAttribute(.link, value: true, range: NSRange(location: 15, length: 6))
