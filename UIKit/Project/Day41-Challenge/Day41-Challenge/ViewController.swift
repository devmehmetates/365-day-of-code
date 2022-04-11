//
//  ViewController.swift
//  Day41-Challenge
//
//  Created by Mehmet Ateş on 10.02.2022.
//

import UIKit


class ViewController: UIViewController {
    
    var answer = ""
    var currentLevel = 0{
        didSet{
            answer = levels[currentLevel]
        }
    }
    
    var levels = [
        "THIS",
        "IS",
        "A",
        "HANGMAN",
        "GAME",
        "MADE",
        "USING",
        "SWIFT",
        "CONGRATULATIONS"
    ]
    
    var allLetters = [String]()
    var correctIndexs = [Int : String]()
    var letterButtonView : UIView!
    
    // Kullanıcı cevabını günceller
    var userAnswer = ""{
        didSet{
            userAnswerLabel.text = userAnswer
        }
    }
    var userAnswerLabel : UILabel!
    
    
    // Yanlış cevapları sayar
    var wrongAnswers = 0{
        didSet{
            wrongAnswerLabel.text = "Wrong Answers: \(wrongAnswers)"
        }
    }
    var wrongAnswerLabel : UILabel!
    
    
    // Skor hesaplar
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var scoreLabel : UILabel!
    
    
    // Kullanılmış butonları tutar
    var usedLetters = [String]()
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        
        self.answer = self.levels[currentLevel]
        
        // Tüm harfleri butona çevirir
        for char in "abcdefghijklmnopqrstuvwxyz" {
            let appendChar = char.uppercased()
            allLetters.append(appendChar)
        }
        
        letterButtonView = UIView()
        letterButtonView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(letterButtonView)
        
        let width = 50
        let heigth = 40
        var row = 0
        var column = 0
        
        for (index,letter) in allLetters.enumerated() {
            if index != 0 {
                column += 1
                if index % 6 == 0{
                    row += 1
                    column = 0
                }
            }
            
            let letterButton = UIButton(type: .system)
            letterButton.setTitle(String(letter), for: .normal)
            let frame = CGRect(x: column * width, y: row * heigth, width: width, height: heigth)
            letterButton.frame = frame
            letterButton.addTarget(self, action: #selector(buttonTabbed), for: .touchUpInside)
            letterButtonView.addSubview(letterButton)
        }
        
        
        // Mecvut cevabın tutulduğu texti oluşturur
        userAnswerLabel = UILabel()
        userAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        userAnswerLabel.textAlignment = .center
        userAnswerLabel.font = UIFont.systemFont(ofSize: 40)
        userAnswerLabel.text = userAnswer
        view.addSubview(userAnswerLabel)
        
        for _ in 0..<answer.count{
            userAnswer += "?"
        }
        
        // Yanlış cevapların tutulduğu texti oluşturur
        wrongAnswerLabel = UILabel()
        wrongAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
        wrongAnswerLabel.textAlignment = .right
        wrongAnswerLabel.font = UIFont.systemFont(ofSize: 10)
        wrongAnswerLabel.text = "Wrong Answers: \(wrongAnswers)"
        view.addSubview(wrongAnswerLabel)
        
        // skorun tutulduğu texti oluşturur
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .left
        scoreLabel.font = UIFont.systemFont(ofSize: 10)
        scoreLabel.text = "Score: \(score)"
        view.addSubview(scoreLabel)
        
        
        // Ekranda ki görüntü düzenini sağlar
        NSLayoutConstraint.activate([
            letterButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letterButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            letterButtonView.heightAnchor.constraint(equalToConstant: 200),
            letterButtonView.widthAnchor.constraint(equalToConstant: 300),
            
            userAnswerLabel.bottomAnchor.constraint(equalTo: letterButtonView.topAnchor, constant: -20),
            userAnswerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            wrongAnswerLabel.bottomAnchor.constraint(equalTo: userAnswerLabel.topAnchor, constant: -20),
            wrongAnswerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 50),
            wrongAnswerLabel.widthAnchor.constraint(equalToConstant: 100),
            
            scoreLabel.bottomAnchor.constraint(equalTo: userAnswerLabel.topAnchor, constant: -20),
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -50),
            scoreLabel.widthAnchor.constraint(equalToConstant: 100)
            

        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func buttonTabbed(_ sender : UIButton){
        if !usedLetters.contains((sender.titleLabel?.text)!){
            userAnswer = ""
            for (index,answerLetter) in answer.enumerated(){
                if sender.titleLabel?.text == String(answerLetter){
                    userAnswer += String(answerLetter)
                    correctIndexs[index] = String(answerLetter)
                    continue
                }
                if correctIndexs.keys.contains(index){
                    userAnswer += correctIndexs[index]!
                    continue
                }
                userAnswer += "?"
            }
            
            if correctIndexs.values.contains((sender.titleLabel?.text)!.uppercased()) {
                score += 1
            }else{
                score -= 1
                wrongAnswers += 1
            }
            
            sender.isEnabled = false
            usedLetters.append((sender.titleLabel?.text)!)
        }
        
        if wrongAnswers == 7{
            self.showAlert(title: "You died!", message: "Try Again!", passed: false)
        }
        
        if !userAnswer.contains("?"){
            self.showAlert(title: "Passed!", message: "Let's Go!", passed: true)
        }
    }
    
    func showAlert(title : String, message : String? = nil, passed: Bool? = false){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if passed!{
            ac.addAction(UIAlertAction.init(title: "Go Next", style: .default, handler: levelUP))
        }else{
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartLevel))
        }
       
        present(ac,animated: true)
    }
    
    func restartLevel(action : UIAlertAction? = nil){
        self.resetScreen()
    }
    
    func levelUP(action : UIAlertAction? = nil){
        if self.levels.count - 1 > self.currentLevel{
            self.currentLevel += 1
            resetScreen()
        }else{
            showAlert(title: "Game Over", message: "Your Score: \(score)\nMaybe you wanna replay this level?", passed: false)
        }
    }
    
    func resetScreen(){
        self.userAnswer = ""
        for _ in 0..<answer.count{
            self.userAnswer += "?"
        }
        self.wrongAnswers = 0
        self.usedLetters.removeAll()
        self.correctIndexs.removeAll()
        for subViews in letterButtonView.subviews{
            guard let button = subViews as? UIButton else { return }
            button.isEnabled = true
        }
    }

}

