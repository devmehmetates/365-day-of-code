//
//  ViewController.swift
//  Day42-44
//
//  Created by Mehmet Ateş on 11.02.2022.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else{
            fatalError("The cell unable")
        }
        cell.imageView.image = UIImage.init(systemName: "star")
        cell.name.text = "Star"
        return cell
        
    }


}

