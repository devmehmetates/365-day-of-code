//
//  CountryTableViewController.swift
//  Day59-Challenge
//
//  Created by Mehmet Ateş on 28.02.2022.
//

import UIKit

class CountryTableViewController: UITableViewController {
    var countryNews = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "News", for: indexPath)
        cell.textLabel?.text = countryNews[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else{ return }
        vc.newDesc = countryNews[indexPath.row].desc
        vc.title = countryNews[indexPath.row].title
        navigationController?.pushViewController(vc, animated: true)
    }
}
