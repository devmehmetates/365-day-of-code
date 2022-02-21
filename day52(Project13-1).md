# Day 52 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day52-54/Day52-54"> Project </a>

## Developing on UISlider and ImagePicker

## Subjects

+ Set-Up
+ Designing the interface
+ Importing a picture


## Designing the interface
The part where we do a set of AutoLayouts with the Storyboard.

## Importing a picture
If you want explanations for this part, please see <a href="https://github.com/devmehmetates/365-day-of-code/blob/main/day43(Project10-2).md">here</a>.
```swift
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var sliderView: UILabel!
    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(takeImage))
        
        // Do any additional setup after loading the view.
    }
    
    @objc func takeImage(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true, completion: nil)
        currentImage = image
    }


    @IBAction func changeFilter(_ sender: Any) {
    }
    
    @IBAction func save(_ sender: Any) {
    }
    
    @IBAction func sliderChange(_ sender: Any) {
    }
}
```



## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

