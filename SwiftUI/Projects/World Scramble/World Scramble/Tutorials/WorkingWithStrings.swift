//
//  WorkingWithStrings.swift
//  World Scramble
//
//  Created by Mehmet Ateş on 23.04.2022.
//

import SwiftUI

struct WorkingWithStrings: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func test1() -> [String]{
        let input = "a b c"
        return input.components(separatedBy: " ")
    }
    
    func test2() -> [String]{
        let input = """
            a
            b
            c
            """
        let letters = input.components(separatedBy: "\n")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return letters
    }
    
    func test3 (){
        let word = "swift"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound

    }
}

struct WorkingWithStrings_Previews: PreviewProvider {
    static var previews: some View {
        WorkingWithStrings()
    }
}
