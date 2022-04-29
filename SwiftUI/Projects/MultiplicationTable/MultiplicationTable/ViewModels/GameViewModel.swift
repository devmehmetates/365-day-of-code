//
//  GameViewModel.swift
//  MultiplicationTable
//
//  Created by Mehmet Ateş on 29.04.2022.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject{
    @Published var answer: (question: String, answer: Int) = ("", 0)
    @Published var choices: Array<String> = []
    @Published var alertToggle: Bool = false
    @Published var alertAnimation: String = ""
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var alertButtonText: String = ""
    @Published var currentQuestion: Int = 0
    @Published var maxQuestion: Int = 0
    @Published var score: Int = 0
    @Published var isDone: Bool = false
    
    
    func askQuestion(constantNumber: Int){
        let realNumber = constantNumber + 1
        let randomValue = Int.random(in: 1...9)
        self.answer = (question: "\(realNumber) x \(randomValue)", answer: realNumber * randomValue)
        self.buildSomeChoice(answer: realNumber * randomValue, constantNumber: realNumber)
    }
    
    func buildSomeChoice(answer: Int, constantNumber: Int){
        var choices = [] as [String]
        
        while choices.count != 3{
            let randomAnswer = constantNumber * Int.random(in: 1...9)
            if randomAnswer != answer && !(choices.contains(String(randomAnswer))){
                choices.append(String(randomAnswer))
            }
        }
        
        choices.append(String(answer))
        choices.shuffle()
        self.choices = choices
    }
    
    func answerChoice(userAnswer: Int){
        self.currentQuestion += 1
        
        if userAnswer == answer.answer{
            score += 1
            alertAnimation = "correct"
            alertTitle = "Tebrikler! Harikasın."
            alertMessage = "Çok güzel. Alıştırma yapmaya devam."
            alertButtonText = "Devam edelim mi?"
        }else{
            alertAnimation = "wrong"
            alertTitle = "Dikkat"
            alertMessage = "Hadi yaa! Biraz daha çalış.\nDoğru cevap:\(answer.answer)"
            alertButtonText = "Devam edelim mi?"
        }
        
        if self.currentQuestion == maxQuestion{
            alertAnimation = "completed"
            alertTitle = "Tamamladık!"
            alertMessage = "Süper! Tüm soruları cevapladık.\nİşte cevapladığın doğru soru sayısı:\(score)"
            alertButtonText = "Başka bir sayıyla pratik yapalım!"
            self.isDone = true
        }
        
        alertToggle.toggle()
    }
    
    func updateMaxQuestion(maxQuestion: Int){
        self.maxQuestion = maxQuestion
    }
}
