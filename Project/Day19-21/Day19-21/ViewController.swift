//
//  ViewController.swift
//  Day19-21
//
//  Created by Mehmet Ateş on 19.01.2022.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correct = 0
    var correctAnswer = 0
    var howMuchQuestion = 0
    
    let center = UNUserNotificationCenter.current()
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNotification()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onTab))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        button1.configuration?.contentInsets.top = 0.0
        button1.configuration?.contentInsets.bottom = 0.0
        button1.configuration?.contentInsets.leading = 0.0
        button1.configuration?.contentInsets.trailing = 0.0
        
        button2.configuration?.contentInsets.top = 0.0
        button2.configuration?.contentInsets.bottom = 0.0
        button2.configuration?.contentInsets.leading = 0.0
        button2.configuration?.contentInsets.trailing = 0.0
        
        button3.configuration?.contentInsets.top = 0.0
        button3.configuration?.contentInsets.bottom = 0.0
        button3.configuration?.contentInsets.leading = 0.0
        button3.configuration?.contentInsets.trailing = 0.0
    }
    
    func registerNotification(){
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Everything is okay")
                self.setNotification()
            } else {
                print("oh no! :(")
            }
        }
    }
    
    func setNotification(){
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Come back! We miss you."
        content.body = "Hey! You wanna a quick game! I know. Come!"
        content.categoryIdentifier = "reminder"
        content.userInfo = ["gamename": "flag game"]
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.day], from: Date.now)
        var dateComponents = DateComponents()
        
        dateComponents.day = (components.day ?? 0) + 1
        dateComponents.hour = 20
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
        print("Trigger Date: \(dateComponents)")
        
    }
    
    @objc func onTab(action: UIAlertAction! = nil){
        let message = """
        Currently score is \(score)
        Tour : \(howMuchQuestion)
        Wrong Answer : \((howMuchQuestion - correct) - 1)
        Correct Answer : \(correct)
        """
        
        let vc = UIAlertController(title: "Score", message: message, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(vc,animated: true)
    }
    
    func askQuestion(action:UIAlertAction! = nil){
        self.button1.transform = .identity
        self.button2.transform = .identity
        self.button3.transform = .identity
        
        howMuchQuestion += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " - Current Score :" + String(score)
    }
    
    func resetGame(action:UIAlertAction! = nil){
        self.button1.transform = .identity
        self.button2.transform = .identity
        self.button3.transform = .identity
        
        score = 0
        howMuchQuestion = 0
        askQuestion()
    }

    @IBAction func buttonTabbed(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        } completion: { finished in
            
            var title : String
            
            if sender.tag == self.correctAnswer{
                title = "Correct"
                self.score += 1
                self.correct += 1
            }else{
                title = "Wrong choice\n" + "That's the flag of : \(self.countries[sender.tag])"
                self.score -= 1
            }
            
            let cc = UIAlertController(title: title, message: "Game is over\n Your score is: \(self.score)", preferredStyle: .alert)
            cc.addAction(UIAlertAction(title: "Reset the game", style: .default, handler: self.resetGame))
            
            let ac = UIAlertController(title: title, message: "Your score is: \(self.score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: self.askQuestion))
            
            
            if self.howMuchQuestion == 10{
                self.present(cc,animated: true)
                
            }else{
                self.present(ac,animated: true)
                
            }
        }
    }
    
}

