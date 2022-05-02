//
//  HomeViewController.swift
//  NetflixCloneUIKit
//
//  Created by Mehmet Ateş on 2.05.2022.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    lazy var box = UIView()
    lazy var topImageView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(topImageView)
        let imageView = UIImageView()
        imageView.image = getImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        
        topImageView.addSubview(imageView)
        topImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.center.equalTo(self.view)
        }
//
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        let imageView2 = UIImageView()
//        imageView2.image = getImage()
//        imageView2.translatesAutoresizingMaskIntoConstraints = false
//
//        let tableView = UIScrollView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.addSubview(imageView)
//        tableView.addSubview(imageView2)
//
//
//        title = "Netflix"
//        view.addSubview(tableView)
//
//        NSLayoutConstraint.activate([
//            tableView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
//            tableView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
//        ])
        
        
        // Do any additional setup after loading the view.
    }
    
    func getImage() -> UIImage{
        let imageData: Data
        var image = UIImage()
        
        do {
            imageData = try Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.png")!)
            image = UIImage(data:imageData)!
        }catch{
            
        }
        
       
        
        return image
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
