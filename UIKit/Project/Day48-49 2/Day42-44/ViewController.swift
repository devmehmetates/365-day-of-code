//
//  ViewController.swift
//  Day42-44
//
//  Created by Mehmet Ateş on 11.02.2022.
//

import UIKit
import LocalAuthentication

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        triggerAuth()
       
        
    }
    
    @objc func triggerAuth(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Identfy yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, AuthError in
                if success{
                    self?.loadPeoples()
                }else{
                    DispatchQueue.main.async {
                        let ac = UIAlertController(title: "Login unsuccessful!", message: "Do you wanna use password?", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Use password", style: .default, handler: self?.unlockWithPassword))
                        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                        self?.present(ac, animated: true)
                    }
                }
            }
        }
    }
    
    func unlockWithPassword(_ action: UIAlertAction? = nil){
        let passwordAc = UIAlertController(title: "Enter Your password", message: nil, preferredStyle: .alert)
        passwordAc.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){ [weak self, weak passwordAc] _ in
            guard let field = passwordAc?.textFields?[0].text else { return }
            self?.checkPassword(password: field)
        }
        
        passwordAc.addAction(submitAction)
        present(passwordAc, animated: true)
    }
    
    func checkPassword(password: String){
        let appPassword = "123456"
        if password == appPassword{
            self.loadPeoples()
        }else{
            let errorAc = UIAlertController(title: "Wrong password", message: nil, preferredStyle: .alert)
            errorAc.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: unlockWithPassword))
            errorAc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorAc, animated: true)
        }
    }
    
    func loadPeoples(){
        let defaults = UserDefaults.standard
        
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                people = try jsonDecoder.decode([Person].self, from: savedPeople)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch {
                print("Failed to load people")
            }
        }
    }
    
    @objc func addNewPerson(){
        let picker  = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknow", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else{
            fatalError("The cell unable")
        }
        
        let person = people[indexPath.item]
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let fac  = UIAlertController(title: "What is your choice", message: nil, preferredStyle: .alert)
        fac.addAction(UIAlertAction(title: "Rename", style: .default){ [weak self] _ in
            let sac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
            sac.addTextField()
            
            sac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            sac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak sac] _ in
                guard let newName = sac?.textFields?[0].text else { return }
                person.name = newName
                self?.save()
                self?.collectionView.reloadData()
            })
            self!.present(sac,animated: true)
        })
        
        fac.addAction(UIAlertAction(title: "Delete", style: .default){ [weak self] _ in
            self?.people.remove(at: indexPath.item)
            self?.collectionView.reloadData()
        })
        
        present(fac, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(people) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        } else {
            print("Failed to save people.")
        }
    }


}

