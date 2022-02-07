//
//  ViewController.swift
//  Day36-38
//
//  Created by Mehmet Ateş on 5.02.2022.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel : UILabel!
    var answersLabel : UILabel!
    var currentAnswer : UITextField!
    var scoreLabel : UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.textAlignment = .right
        answersLabel.text = "ANSWERS"
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.numberOfLines = 0
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        currentAnswer.textAlignment = .center
        currentAnswer.placeholder = "Tab letter to guess"
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clearButton = UIButton(type: .system)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("CLEAR", for: .normal)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clearButton)
        
        let buttonView = UIView()
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(buttonView)
        
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: -100),
            
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-100),
            answersLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 100),
            clearButton.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clearButton.heightAnchor.constraint(equalToConstant: 44),
            
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            buttonView.heightAnchor.constraint(equalToConstant: 340),
            buttonView.widthAnchor.constraint(equalToConstant: 750),
            buttonView.topAnchor.constraint(equalTo: submit.bottomAnchor,constant: 20)
            
        ])
        
        let width = 150
        let heigth = 80
        
        for row in 0..<4{
            for column in 0..<5{
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("www", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * heigth, width: width, height: heigth)
                letterButton.frame = frame
                
                buttonView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLevel()
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }
        
        if let solutionPosition = solutions.firstIndex(of: answerText){
            activatedButtons.removeAll()
            
            var splitAnswer = answersLabel.text?.components(separatedBy: "\n")
            
            splitAnswer?[solutionPosition] = answerText
            answersLabel.text = splitAnswer?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            var levelEnd = true
            for lebutton in letterButtons {
                if lebutton.isHidden == false{
                    levelEnd = false
                    break
                }
            }
            
            if levelEnd{
                if score > 4{
                    showLevelAlert(title: "Well Done", message: "Are you ready to next level?",buttonTitle: "Let's Go!")
                }else{
                    showLevelAlert(title: "Level not completed", message: "Maybe next time?", buttonTitle: "Try Again!")
                }
            }
        }else{
            let wrAc = UIAlertController(title: "Wrong Anwswer", message: "Try Again", preferredStyle: .alert)
            wrAc.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            present(wrAc,animated: true)
            clearTapped(nil)
            score -= 1
        }
    }
    
    func showLevelAlert(title : String, message : String?, buttonTitle : String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if title == "Well Done"{
            ac.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: levelUp))
        }else{
            ac.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: resetLevel))
        }
        present(ac,animated: true)
    }
    
    func levelUp(action : UIAlertAction? = nil){
        level += 1
        solutions.removeAll(keepingCapacity: true)
        score = 0
        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
        }
        
    }
    
    func resetLevel(action : UIAlertAction? = nil){
        solutions.removeAll(keepingCapacity: true)
        score = 0
        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
        }
        
    }
    
    @objc func clearTapped(_ sender: UIButton? = nil) {
        currentAnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    func loadLevel(){
        var cluesString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            if let levelContent = try? String(contentsOf:levelFileURL){
                var lines = levelContent.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index,line) in lines.enumerated(){
                    let parts = line.components(separatedBy: ":")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    cluesString += "\(index + 1). \(clue)\n"
                    let solutionsWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionsWord.count) letters \n"
                    solutions.append(solutionsWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
                
            }
        }
        
        cluesLabel.text = cluesString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count{
            for i in 0..<letterButtons.count{
                letterButtons[i].setTitle(letterBits[i], for: .normal)
                
            }
        }
    }
    
    


}

