//
//  ViewController.swift
//  Day32-Challenge
//
//  Created by Mehmet Ateş on 1.02.2022.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        let rightItems = [UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cleanList)), UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMatter))]
        
        navigationItem.rightBarButtonItems = rightItems
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Matter", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func cleanList(){
        let dac = UIAlertController(title: "Are you sure?", message: "This process cannot be undone", preferredStyle: .alert)
        dac.addAction(UIAlertAction(title: "Delete", style: .default, handler: deleteItems))
        dac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(dac,animated: true)
    }
    
    func deleteItems(action: UIAlertAction? = nil){
        self.shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func shareList(){
        let list = shoppingList.joined(separator: "\n")
        let actvc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        actvc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        
        present(actvc,animated: true)
    }
    
    
    @objc func addMatter(){
        let ac = UIAlertController(title: "Add an matter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let addAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let matter = ac?.textFields?[0].text else { return }
            self?.createMatter(matter)
        }
        ac.addAction(addAction)
        
        present(ac,animated: true)
        
    }
    
    func createMatter(_ matter : String){
        self.shoppingList.insert(matter, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }


}

