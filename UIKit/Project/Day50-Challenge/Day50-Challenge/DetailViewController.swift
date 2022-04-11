//
//  DetailViewController.swift
//  Day50-Challenge
//
//  Created by Mehmet Ateş on 19.02.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var pictureImage: UIImage!
    var pictureName: String!
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = pictureImage
        title = pictureName
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePhoto))
        // Do any additional setup after loading the view.
    }
    
    @objc func sharePhoto(){
        let sc = UIActivityViewController(activityItems: [self.pictureImage, self.pictureName], applicationActivities: nil)
        present(sc,animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
