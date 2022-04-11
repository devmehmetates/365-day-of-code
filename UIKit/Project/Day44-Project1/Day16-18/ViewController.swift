//
//  ViewController.swift
//  Day16-18
//
//  Created by Mehmet Ateş on 15.01.2022.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(self.getPhotos), with: nil)
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .none
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onTab))
        print(pictures)
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
            self.collectionView.reloadData()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else{
            fatalError("The cell unable")
        }
        cell.image.image = UIImage(named: pictures[indexPath.row])
        cell.label.text = pictures[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.count = self.pictures.count
            vc.selectedIndex = indexPath.row
            vc.selectedImage = pictures[indexPath.row]
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

