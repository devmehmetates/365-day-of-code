//
//  ViewController.swift
//  Day19-21
//
//  Created by Mehmet Ateş on 19.01.2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
        
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
    
    func askQuestion(action:UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() 
    }

    @IBAction func buttonTabbed(_ sender: UIButton) {
        var title : String
        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
        }else{
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac,animated: true)
        
        
    }
    
}

