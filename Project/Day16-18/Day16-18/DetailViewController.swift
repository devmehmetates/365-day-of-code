//
//  DetailViewController.swift
//  Day16-18
//
//  Created by Mehmet Ateş on 17.01.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage : String?
    var count : Int = 0
    var selectedIndex : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(selectedImage != "", "Photo Error!")
        
        title = "Picture \(selectedIndex + 1) of \(count)"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = .systemBackground
        if let loadImage = self.selectedImage{
            imageView.image = UIImage(named: loadImage)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
