//
//  DetailViewController.swift
//  Day59-Challenge
//
//  Created by Mehmet Ateş on 28.02.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var text: UILabel!
    
    var newDesc: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        text.text = newDesc
        // Do any additional setup after loading the view.
    }
}
