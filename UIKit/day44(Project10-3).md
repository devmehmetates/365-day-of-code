# Day 44 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day36-38"> Project </a>

## Developing on Subviews - UIProperties - NSLayoutConstraint and UI Design on iPad

## Subjects

+ Wrap Up
+ Challenges

## Challenges
Let's solve today's challenges.

+ Add a second UIAlertController that gets shown when the user taps a picture, asking them whether they want to rename the person or delete them.
+ Try using picker.sourceType = .camera when creating your image picker, which will tell it to create a new image by taking a photo. This is only available on devices (not on the simulator) so you might want to check the return value of UIImagePickerController.isSourceTypeAvailable() before trying to use it!
+ Modify project 1 so that it uses a collection view controller rather than a table view controller. I recommend you keep a copy of your original table view controller code so you can refer back to it later on.

### Add a second UIAlertController that gets shown when the user taps a picture, asking them whether they want to rename the person or delete them.

```swift
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
```

### Try using picker.sourceType = .camera when creating your image picker, which will tell it to create a new image by taking a photo. This is only available on devices (not on the simulator) so you might want to check the return value of UIImagePickerController.isSourceTypeAvailable() before trying to use it!
```swift
...
if UIImagePickerController.isSourceTypeAvailable(.camera){
    picker.sourceType = .camera
}
...
```

### Modify project 1 so that it uses a collection view controller rather than a table view controller. I recommend you keep a copy of your original table view controller code so you can refer back to it later on.

<a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day44-Project1">Project</a>


## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">










