//
//  EditTableViewController.swift
//  Day99
//
//  Created by Mehmet Ateş on 9.04.2022.
//

import UIKit

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
