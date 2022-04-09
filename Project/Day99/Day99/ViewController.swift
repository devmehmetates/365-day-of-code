//
//  ViewController.swift
//  Day99
//
//  Created by Mehmet Ateş on 9.04.2022.
//

import UIKit

class ViewController: UICollectionViewController {
    var selectedCardSequence: Int = 0
    var firstCell: UICollectionViewCell?
    var score: Int = 0
    let words = [
        "Turkey" : "Türkiye",
        "World" : "Dünya",
        "Swift" : "Hızlı",
        "Welcome" : "Hoşgeldin",
        "Hello" : "Merhaba",
        "Love" : "Sevgi",
        "Hate" : "Nefret",
        "Mine" : "Benim",
        "Run" : "Koşmak",
    ]
    
    var wordsKey = [
        "Turkey",
        "World",
        "Swift",
        "Welcome",
        "Hello",
        "Love",
        "Hate",
        "Mine",
        "Run",
    ]
    
    var wordsValue = [
        "Türkiye",
        "Dünya",
        "Hızlı",
        "Hoşgeldin",
        "Merhaba",
        "Sevgi",
        "Nefret",
        "Benim",
        "Koşmak",
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Find It"
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.red
        cell.contentView.backgroundColor = UIColor.red
        
        let whatIsRandomElement = [wordsKey.randomElement(), wordsValue.randomElement()]
        let randomElement = whatIsRandomElement.randomElement() ?? ""
        
        let keyIndex = wordsKey.firstIndex(of: randomElement ?? "")
        let valueIndex = wordsValue.firstIndex(of: randomElement ?? "")
        
        if keyIndex != nil{
            wordsKey.remove(at: keyIndex!)
        }else if valueIndex != nil{
            wordsValue.remove(at: valueIndex!)
        }
        
        cell.cardLabel.text = randomElement
        cell.questionMark.isHidden = false
        cell.cardLabel.isHidden = true
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedCardSequence >= 2 {
            return
        }
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        if firstCell == nil{
            self.firstCell = cell
        }
        
        if firstCell! == cell && self.selectedCardSequence != 0{
            return
        }
        
        self.selectedCardSequence += 1
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        let transitionBackOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        
        UIView.transition(with: cell, duration: 1.0, options: transitionOptions, animations: {
            cell.questionMark.isHidden = true
            cell.cardLabel.isHidden = false
        })
        
        if self.selectedCardSequence == 2{
            let firstCell = self.firstCell as! CollectionViewCell
            if words[firstCell.cardLabel.text!] == cell.cardLabel.text! || words[cell.cardLabel.text!] == firstCell.cardLabel.text!  {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.firstCell!.isHidden = true
                    cell.isHidden = true
                    self.score += 1
                    let ac = UIAlertController(title: "Correct", message: "Your score is \(self.score)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Okay", style: .cancel))
                    self.present(ac, animated: true)
                    self.firstCell = nil
                    self.selectedCardSequence = 0
                }
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    UIView.transition(with: self.firstCell!, duration: 1.0, options: transitionBackOptions, animations: {
                        firstCell.questionMark.isHidden = false
                        firstCell.cardLabel.isHidden = true
                        
                    })
                    UIView.transition(with: cell, duration: 1.0, options: transitionBackOptions, animations: {
                        cell.questionMark.isHidden = false
                        cell.cardLabel.isHidden = true
                    })
                    self.firstCell = nil
                    self.selectedCardSequence = 0
                }
            }
        }
    }
}

