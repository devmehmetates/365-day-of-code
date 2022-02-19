//
//  ViewController.swift
//  Day50-Challenge
//
//  Created by Mehmet Ateş on 19.02.2022.
//

import UIKit

class ViewController:UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let defaults = UserDefaults.standard
    var images = [UIImage]()
    var imagesNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        self.images = defaults.object(forKey: "images") as? Array<UIImage> ?? [UIImage]()
        self.imagesNames = defaults.object(forKey: "imageNames") as? Array<String> ?? [String]()
        
    }
    
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
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        self.images.append(image)
        
//        defaults.set(images, forKey: "images")
//        defaults.set(imagesNames, forKey: "imageNames")
        dismiss(animated: true)
        getImageName()
    }
    
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = imagesNames[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.pictureImage = images[indexPath.row]
            vc.pictureName = imagesNames[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

