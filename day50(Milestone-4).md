# Day 50 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day50-Challenge"> Project </a>

##  Project1 + Project10

+ Challenge

## Challenge

### First Step - Take pictures by camera
```swift
class ViewController:UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
...
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
...
```
Set a button for action!
```swift
@objc func addPhoto(){
    let picker = UIImagePickerController()
    if UIImagePickerController.isSourceTypeAvailable(.camera){
        picker.sourceType = .camera
    }
    picker.allowsEditing = true
    picker.delegate = self
    present(picker,animated: true)
}

func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }

    let imageName = UUID().uuidString

    if let jpegData = image.jpegData(compressionQuality: 0.8) {
        try? jpegData.write(to: imagePath)
    }
    self.images.append(image)

    dismiss(animated: true)
    getImageName() // Later
}
```
+ If camera is avaiable set source type to camera. Open editting proterties and take photos
+ If photo was collected set a Id for photo and get photo path
+ If everything is okay add image to images list
+ Close image picker and call name alert

```swift
func getImageName(){
    let ac = UIAlertController(title: "Enter picture name", message: nil, preferredStyle: .alert)
    ac.addTextField()

    ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self, weak ac] _ in
        guard let pictureName = ac?.textFields?[0].text else { return }
        self?.imagesNames.append(pictureName)

        self?.tableView.reloadData()
    }))

    present(ac,animated: true)
}
```
+ Create an alert for setting image name
+ Add an textfield for alert
+ Take entered name and add imagesNames list
+ Reload your table

```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = imagesNames[indexPath.row]
    return cell
}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return images.count
}
```
+ Fiil your table with imagesNames

```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
        vc.pictureImage = images[indexPath.row]
        vc.pictureName = imagesNames[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
```
+ Orient view by clicked item to detailView

```swift
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
```
+ Set view image by taked image 
+ Set title by taked name
+ Add share button 
+ Provide share for image and name
+ Add viewAppear properties for hide navBar

## Results
Camera will worked on real devices. I was tested app, everything is fine.
<div>
  <img src="https://user-images.githubusercontent.com/74152011/154809910-28758278-218f-4a31-8f0e-bae237814404.png" width=280>
  <img src="https://user-images.githubusercontent.com/74152011/154809923-3b553761-6737-4e18-9095-2b99e0c6d97f.png" width=280>
  <img src="https://user-images.githubusercontent.com/74152011/154809927-f0c305e7-4568-4018-92d7-5daa2325522a.png" width=280>
  <img src="https://user-images.githubusercontent.com/74152011/154809930-82a323c4-9bd0-4319-a5be-8477076dea40.png" width=280>
  <img src="https://user-images.githubusercontent.com/74152011/154809935-82617189-5fbb-4235-bfd3-6cbaf63e1941.png" width=280>
</div>

## Great Work :)

<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="700" height="500"/>

