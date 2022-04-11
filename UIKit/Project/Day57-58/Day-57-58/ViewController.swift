//
//  ViewController.swift
//  Day-57-58
//
//  Created by Mehmet Ateş on 26.02.2022.
//

import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView!
    var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
        
    }

    @IBAction func tabbed(_ sender: UIButton) {
        sender.isHidden = true
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
            switch self.currentAnimation{
            case .zero:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                break
            case 1:
                self.imageView.transform = .identity
                break
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                break
            case 3:
                self.imageView.transform = .identity
                break
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                break
            case 5:
                self.imageView.transform = .identity
                break
            case 6:
                self.imageView.alpha = 0.1
                self.imageView.backgroundColor = UIColor.green
                break
            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = UIColor.clear
                break
            default:
                break
            }
        } completion: { finished in
            sender.isHidden = false
        }

        currentAnimation += 1
        
        if currentAnimation > 7{
            currentAnimation = 0
        }
    }
    
}

