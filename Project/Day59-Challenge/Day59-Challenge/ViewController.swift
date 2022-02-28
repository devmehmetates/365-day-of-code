//
//  ViewController.swift
//  Day59-Challenge
//
//  Created by Mehmet Ateş on 28.02.2022.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [CountryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select a Country"
        let data = readLocalFile(forName: "data")
        self.parse(jsonData: data!)
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(DataModel.self,
                                                       from: jsonData)
            self.countries = decodedData.data
        } catch {
            print("decode error")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CountryNews") as? CountryTableViewController else{ return }
        vc.countryNews = countries[indexPath.row].data
        vc.title = countries[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
    }
}

