//
//  Card.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 21.06.2022.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
