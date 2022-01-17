# Day 17 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day16-18"> Project </a>

## Begin to the iOS

## Subjects

+ Detail Screen
+ UIImage
+ Image and Navigation Properties

## Detail Screen

I created a new cocoa touch class and bound my storyboard page with this class
```swift
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = .systemBackground
        if let loadImage = self.selectedImage{
            imageView.image = UIImage(named: loadImage)
        }
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
```

## UIImage
I sent the image names to the cocoa touch class i just created

```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
        vc.selectedImage = pictures[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
```
```swift
if let loadImage = self.selectedImage{
    imageView.image = UIImage(named: loadImage)
}
```

## Image and Navigation Properties
```swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
}

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
}
```
```swift
navigationItem.largeTitleDisplayMode = .never
navigationController?.navigationBar.backgroundColor = .systemBackground
```
```swift
title = "Storm Viewer"
navigationController?.navigationBar.prefersLargeTitles = true
navigationController?.navigationBar.backgroundColor = .none
```

## Result

<img src="https://user-images.githubusercontent.com/74152011/149744035-2cce6d4e-1058-4065-aa3c-cf0dc609569e.png" width=325> <img src="https://user-images.githubusercontent.com/74152011/149744065-bc9122b1-e7d9-4504-b52b-de3b059574ac.png" width=325> <img src="https://user-images.githubusercontent.com/74152011/149744185-bc98236a-5cfa-469b-8ef4-ed6709fb6ee2.png" width=325> 
