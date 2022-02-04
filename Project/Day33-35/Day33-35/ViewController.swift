//
//  ViewController.swift
//  Day33-35
//
//  Created by Mehmet Ateş on 3.02.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var mainPetitions = [Petition]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String
        
        
        let leftItems = [UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchFilter)), UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearFilter))]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showInformation))
        navigationItem.leftBarButtonItems = leftItems
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    @objc func clearFilter(){
        if !self.mainPetitions.isEmpty{
            self.petitions = self.mainPetitions
        }
        tableView.reloadData()
    }
    
    @objc func searchFilter(){
        let sac = UIAlertController(title:"Search any word", message: "Enter your keyword",preferredStyle: .alert)
        sac.addTextField()
        
        let submitAction = UIAlertAction(title: "Search", style: .default) { [weak self, weak sac] _ in
            var keys = [String]()
            guard let count = sac?.textFields?.count else{return}
            for textIndex in 0..<count{
                if let collectAnswer = sac?.textFields?[textIndex]{
                    keys.append(collectAnswer.text ?? "")
                }
            }
            self?.searchWord(keys)
        }
        
        sac.addAction(submitAction)
        present(sac,animated: true)
    }
    
    func searchWord(_ keys : [String]){
        if !mainPetitions.isEmpty{
            self.petitions = mainPetitions
        }
        var changePetition = [Petition]()
        for petition in petitions {
            if petition.body.lowercased().contains(keys[0].lowercased()){
                changePetition.append(petition)
            }
        }
        self.mainPetitions = self.petitions
        self.petitions = changePetition
        tableView.reloadData()
    }
    
    @objc func showInformation(){
        let iac = UIAlertController(title: "Information", message: "This information got by White House API", preferredStyle: .alert)
        iac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(iac,animated: true)
    }
    
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "Please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            self.petitions = jsonPetitions.results
            self.tableView.reloadData()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

