# Day99 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day99/Day99">Project</a>

## A different day.
I am really happy today. I am about to proudly complete the first part of this long adventure. Thank you to everyone who supported me during this process.

## Challenge
Yes. Today we have quite a long challenge. But it doesn't matter. I will share with you every detail. Our topic is to make a card game. Find and win.
Let's take a look at the requirements presented to us first.

### Must be do
+ Come up with a list of pairs. Traditionally this is two pictures, but you could also use capital cities (e.g. one card says France and its match says Paris), languages (e.g one card says “hello” and the other says “bonjour”), and so on.
+ Show a grid of face-down cards. How many is down to you, but if you’re targeting iPad I would have thought 4x4 or more.
+ Let the player select any two cards, and show them face up as they are tapped.
+ If they match remove them; if they don’t match, wait a second then turn them face down again.
+ Show a You Win message once all are matched.

### Optional
+ Authenticating users using Touch ID or Face ID.
+ Showing a new view controller that lists all existing cards and lets them enter a new card.
+ You can use a UIAlertController with one or two text fields for your card entry, depending on what kind of game you’ve made.

Of course, we made all of these items. Although it doesn't look very nice visually, it's definitely functionally very good. And visuality can look very good even with the changes I will make on the storyboard alone. Alright then let's get started.

## Authenticating
```swift
//
//  HomeViewController.swift
//  Day99
//
//  Created by Mehmet Ateş on 9.04.2022.
//

import UIKit
import LocalAuthentication

class HomeViewController: UIViewController {
    @IBOutlet var playButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.isEnabled = false
        editButton.isEnabled = false

        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Identfy yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, accessError in
                DispatchQueue.main.async {
                    if success {
                        self?.playButton.isEnabled = true
                        self?.editButton.isEnabled = true
                    }else{
                        let ac = UIAlertController(title: "Login unsuccessful!", message: "Do you wanna use password?", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Use password", style: .default, handler: self?.unlockWithPassword))
                        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                        self?.present(ac, animated: true)
                    }
                }
                
            }
        }else{
            let ac = UIAlertController(title: "Your device not have a enrolled face id or not support to face id", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "okay", style: .cancel))
            self.present(ac, animated: true)
        }
    }
    
    func unlockWithPassword(_ action: UIAlertAction? = nil){
        let passwordAc = UIAlertController(title: "Enter Your password", message: nil, preferredStyle: .alert)
        passwordAc.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){ [weak self, weak passwordAc] _ in
            guard let field = passwordAc?.textFields?[0].text else { return }
            self?.checkPassword(password: field)
        }
        
        passwordAc.addAction(submitAction)
        present(passwordAc, animated: true)
    }
    
    func checkPassword(password: String){
        let appPassword = "123456"
        if password == appPassword{
            self.playButton.isEnabled = true
            self.editButton.isEnabled = true
        }else{
            let errorAc = UIAlertController(title: "Wrong password", message: nil, preferredStyle: .alert)
            errorAc.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: unlockWithPassword))
            errorAc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorAc, animated: true)
        }
    }

    
    @IBAction func playButtonTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PlayScreen") else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "EditScreen") else { return }
        navigationController?.pushViewController(vc, animated: true)
    }

}
```
OK, let's be calm. They are really very, very familiar codes for us. A screen that is triggered as soon as we enter the application, where we can log in with both biometric and password, and is closed to our access until we receive approval. Yes, I know I wrote it without breathing, but this is exactly the page. It also contains small directions. Pretty simple isn't it?

## Edit Screen
Our first page was really easy. That's why we gave it all at once. Now let's slow down a bit and dig deeper.

```swift
class EditTableViewController: UITableViewController {
    let defaults = UserDefaults.standard
    var words = Array<[String: String]>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.words = defaults.object(forKey: "Keys") as? Array<[String: String]> ?? []

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveKeys))
        
        if self.words.count == 18 { navigationItem.rightBarButtonItem?.isEnabled = false }
        
        title = "Game Keys: \(18 - words.count) required"
        
    }
...
```
Now what does this piece tell us? Read the registered letters and decide whether I can add new according to their number. Well, let's show them to the user in the header, shall we?

```swift
@objc func saveKeys(){
    let ac = UIAlertController(title: "Save words", message: "First: English\nSecond: Turkish", preferredStyle: .alert)
    ac.addTextField()
    ac.addTextField()

    let submit = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
        let english = ac?.textFields?[0].text ?? ""
        let turkish = ac?.textFields?[1].text ?? ""
        if english.isEmpty || turkish.isEmpty{
            self?.showError()
            return
        }
        self?.saveKeysToDefaults(english: english, turkish: turkish)
    }

    ac.addAction(submit)
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)

}

func showError(){
    let ac = UIAlertController(title: "Save Error!", message: "Please enter all fields!", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
}

func saveKeysToDefaults(english: String, turkish: String){
    self.words.insert([english : turkish], at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .fade)
    title = "Game Keys: \(18 - words.count) required"
    DispatchQueue.global(qos: .background).async {
        self.defaults.set(self.words, forKey: "Keys")
    }
}
```
Hmm, our registration process is being done here as well. We used the tableview functions for great images. These parts look really, really nice. Of course, we also have certain warnings and rules. And in this part, we are using an alert with 2 fields for the first time. Isn't it great?

```swift
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditCell", for: indexPath)
        cell.textLabel?.text = (words[indexPath.row].keys.first ?? "") + ": " + (words[indexPath.row].values.first ?? "")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.words.remove(at: indexPath.row)
            title = "Game Keys: \(18 - words.count) required"
            tableView.deleteRows(at: [indexPath], with: .left)
            DispatchQueue.global(qos: .background).async {
                self.defaults.set(self.words, forKey: "Keys")
            }
        }
    }
}
```
This is where our deletions and creation of table views happen. There is nothing to tell. Everything is open.

## Game
We come to the most tiring part. But the biggest impact is really here.
```swift
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
```
Now we see a lot of definitions. But they may not be necessary. Although there are editable codes, it is quite enough for now. In the same way, we need to read the data we recorded here. But here the structure is a little different. Words and meanings need to be randomly scattered across the screen. That's why we have these lists. In this section, you may have noticed the divisibility control by 3 as an extra. The screen should be seen correctly!

```swift
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
```
Here's the random thing. Here is what I did. There are word pairs that need to be scattered all over the screen and these are kept in a series of separate lists. If I delete an element from an array its match should not be empty and should be inserted. To prevent these, we have controls here and functions that safely place all the elements. The hiding in the last part is to make the picture and the value look like a real card.

```swift
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
```
Haha, that's the last episode. But almost all transactions take place here. It will be more descriptive to write it in articles here. Let's start.

## Simple targets
+ Now our first topic is this. The first click also returned. Then, what will happen? Our game works with 2 cards. We have to wait and keep the first card in memory.
+ We open two cards. should they go back? After two cards are exposed, the match is checked. if unsuccessful, the cards are turned away. If there is a successful match, it is hidden.

Basically they are really simple. So what kind of problems did we have?
## Problems and fixs
+ The user can click the selected card again. How do you solve it? 
+ + We recorded the first card. Let's compare the two and check. Since there will be no first card on the first click, the card clicked will always be equal to the first card. ❌
+ + Check this event only if a card has been clicked before. That means making sure that the first card exists. ✅
+ While the cards are open, another card can be clicked.
+ + Let's use our counter to avoid clicking more than 2 cards. And let's continue the operations on the condition that it is less than 2.

## Hacking with Swift - 100 Days Of Swift - Mehmet ATEŞ
<div>
  <img src="https://media4.giphy.com/media/1HZ1wggAdwVIA/giphy.gif">
  <img src="https://media4.giphy.com/media/1HZ1wggAdwVIA/giphy.gif">
  <img src="https://media4.giphy.com/media/1HZ1wggAdwVIA/giphy.gif">
</div>





