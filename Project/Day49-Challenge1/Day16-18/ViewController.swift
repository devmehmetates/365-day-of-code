//
//  ViewController.swift
//  Day16-18
//
//  Created by Mehmet Ateş on 15.01.2022.
//

import UIKit

class ViewController: UITableViewController {
    let defaults = UserDefaults.standard
    var pictures = [String]()
    var picturesShowCount = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(self.getPhotos), with: nil)
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onTab))
        print(pictures)
        
        for picture in pictures{
            picturesShowCount.append(defaults.object(forKey: picture) as? Int ?? 0)
        }
        // Do any additional setup after loading the view.
        
    }
    
    @objc func getPhotos(){
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
            
        }
        pictures.sort()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let showingCount = defaults.object(forKey: pictures[indexPath.row]) as? Int ?? 0
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = String(showingCount)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.count = self.pictures.count
            vc.selectedIndex = indexPath.row
            vc.selectedImage = pictures[indexPath.row]
            defaults.set(picturesShowCount[indexPath.row] + 1, forKey: pictures[indexPath.row])
            picturesShowCount[indexPath.row] = picturesShowCount[indexPath.row] + 1
            self.tableView.reloadData()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func onTab(){
        let message = "This's awesome app. You should be try :)"
        let appLink = "https://github.com/devmehmetates"
        
        let vc  = UIActivityViewController(activityItems: [message,appLink], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc,animated: true)
    }


}

