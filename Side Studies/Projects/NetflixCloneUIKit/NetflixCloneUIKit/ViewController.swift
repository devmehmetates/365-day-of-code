//
//  ViewController.swift
//  NetflixCloneUIKit
//
//  Created by Mehmet Ateş on 1.05.2022.
//

import UIKit

class ViewController: UIViewController {
    var label1: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1 = UILabel()
        label1.text = "Deneme"
        label1.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label1)
        
        
        NSLayoutConstraint.activate([
            label1.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
        // Do any additional setup after loading the view.
    }


}

