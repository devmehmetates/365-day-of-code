//
//  ViewController.swift
//  Day23
//
//  Created by Mehmet Ateş on 23.01.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var flagImage: UIImageView!
    var selectedFlag : String?
    var selectedName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onTab))
        
        flagImage.layer.borderWidth = 1
        flagImage.layer.borderColor = UIColor.gray.cgColor
        
        if let selectedName = selectedName {
            title = selectedName
        }
        if let loadImage = self.selectedFlag{
            flagImage.image = UIImage(named: loadImage)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func onTab(){
        guard let flag = UIImage(named: self.selectedFlag!)?.jpegData(compressionQuality: 0.8)else{
            print("FLag not found")
            return
        }
        
        guard let name = self.selectedName else{
            print("name not found")
            return
        }
        
        let ac = UIActivityViewController(activityItems: [flag,name], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac,animated: true)
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

