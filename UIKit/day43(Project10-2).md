# Day 43 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day42-44"> Project </a>

## Developing on UIImagePickerController, NSObject

## Subjects

+ Importing photos with UIImagePickerController
+ Custom subclasses of NSObject
+ Connecting up the people

## Importing photos with UIImagePickerController
Let's code this section. We will create UIImagePickerController

```swift
...
navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
...

@objc func addNewPerson() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
}
```
Now we have a photo that we can edit with a button.

```swift
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }

    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

    if let jpegData = image.jpegData(compressionQuality: 0.8) {
        try? jpegData.write(to: imagePath)
    }

    dismiss(animated: true)
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
```

## Custom subclasses of NSObject

```swift
class Person: NSObject {

    var name : String
    var image : String
    
    init (name : String, image : String){
        self.name = name
        self.image = image
    }
    
}
```

```swift
class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var people = [Person]()
...
```
```swift
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
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
```  
Here we expanded our function

## Connecting up the people
```swift
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
```
And now our photos are added to our cells.
```swift
override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = people[indexPath.item]


    let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
    ac.addTextField()

    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
        guard let newName = ac?.textFields?[0].text else { return }
        person.name = newName

        self?.collectionView.reloadData()
    })

    present(ac, animated: true)
}
```
And finally, when we click on the cell, we open a warning that we will change the name of the cell.

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

