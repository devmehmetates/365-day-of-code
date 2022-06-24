//
//  Card.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 21.06.2022.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id = UUID()
    let prompt: String
    let questionAnswer: String
    let answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", questionAnswer: "Jodie Whittaker")
    
    init(prompt: String, questionAnswer: String, answer: String? = nil){
        self.prompt = prompt
        self.questionAnswer = questionAnswer
        
        if answer == nil{
            self.answer = questionAnswer
        }else{
            self.answer = answer!
        }
    }
}
