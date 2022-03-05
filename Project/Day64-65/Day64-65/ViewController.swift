//
//  ViewController.swift
//  Day64-65
//
//  Created by Mehmet Ateş on 5.03.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // First Section
        print (1, 2, 3, 4, 5, separator: "-")
        print("Super mege message", terminator: "**")
        
        // Second Section
        assert(1==1, "Math Error!")
//        assert(1==2, "Math Error!")
        
        // Thirt Section
        for i in 1 ... 100 {
            print("Got number \(i)")
        }
    }


}

