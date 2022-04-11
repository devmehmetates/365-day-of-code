//
//  ViewController.swift
//  Day99
//
//  Created by Mehmet Ateş on 9.04.2022.
//

import UIKit

class ViewController: UICollectionViewController {
    let defaults = UserDefaults.standard
    var selectedCardSequence: Int = 0
    var firstCell: UICollectionViewCell?
    var savedwords = Array<[String: String]>()
    var words = [String: String]()
    var wordsKey = [String]()
    var wordsValue = [String]()
    var score: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Find It"
        
        self.savedwords = defaults.object(forKey: "Keys") as? Array<[String: String]> ?? []
        print(savedwords.count)
        
        if !savedwords.count.isMultiple(of: 3){
            self.showError(title: "Your keys is invalid!", message: "Please check and edit your keys.\nNote: Your keys count must be multiple of 3.")
            self.words.removeAll()
        }else{
            for words in self.savedwords{
                self.words[words.keys.first ?? ""] = words.values.first ?? ""
                self.wordsKey.append(words.keys.first ?? "")
                self.wordsValue.append(words.values.first ?? "")
            }
        }
        
    }
                
    func showError(title: String? = nil, message: String? = nil){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .cancel))
        present(ac, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.red
        cell.contentView.backgroundColor = UIColor.red
        
        let whatIsRandomElement = [wordsKey.randomElement(), wordsValue.randomElement()]
        let randomElement = (whatIsRandomElement.randomElement() ?? "") ?? ""
        
        let keyIndex = wordsKey.firstIndex(of: randomElement)
        let valueIndex = wordsValue.firstIndex(of: randomElement)
        
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

