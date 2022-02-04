# Day 35 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day33-35"> Project </a>

## Developing on WebKit

## Subjects

+ Wrap Up
+ Challenge

## Challenge

### Add a Credits button to the top-right corner using UIBarButtonItem. When this is tapped, show an alert telling users the data comes from the We The People API of the Whitehouse.

```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showInformation))

@objc func showInformation(){
    let iac = UIAlertController(title: "Information", message: "This information got by White House API", preferredStyle: .alert)
    iac.addAction(UIAlertAction(title: "OK", style: .default))

    present(iac,animated: true)
}
```

### Let users filter the petitions they see. This involves creating a second array of filtered items that contains only petitions matching a string the user entered. Use a UIAlertController with a text field to let them enter that string. This is a tough one, so I’ve included some hints below if you get stuck
```swift
let leftItems = [UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchFilter)), UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearFilter))]
        
navigationItem.leftBarButtonItems = leftItems
```
```swift
@objc func clearFilter(){
    if !self.mainPetitions.isEmpty{
        self.petitions = self.mainPetitions
    }
    tableView.reloadData()
}

@objc func searchFilter(){
    let sac = UIAlertController(title:"Search any word", message: "Enter your keyword",preferredStyle: .alert)
    sac.addTextField()

    let submitAction = UIAlertAction(title: "Search", style: .default) { [weak self, weak sac] _ in
        var keys = [String]()
        guard let count = sac?.textFields?.count else{return}
        for textIndex in 0..<count{
            if let collectAnswer = sac?.textFields?[textIndex]{
                keys.append(collectAnswer.text ?? "")
            }
        }
        self?.searchWord(keys)
    }

    sac.addAction(submitAction)
    present(sac,animated: true)
}

func searchWord(_ keys : [String]){
    if !mainPetitions.isEmpty{
        self.petitions = mainPetitions
    }
    var changePetition = [Petition]()
    for petition in petitions {
        if petition.body.lowercased().contains(keys[0].lowercased()){
            changePetition.append(petition)
        }
    }
    self.mainPetitions = self.petitions
    self.petitions = changePetition
    tableView.reloadData()
}
```
### Html section
I already had some experience with html. And today was a very tiring day at work. So I skipped this part for now.


## Result

<div>
  <img src="https://user-images.githubusercontent.com/74152011/152591535-4c5f2d32-279e-4d9a-90cd-934c6f0e0f64.png" width=220>
  <img src="https://user-images.githubusercontent.com/74152011/152591542-c2c083be-0d71-4045-b174-51781bb33892.png" width=220>
  <img src="https://user-images.githubusercontent.com/74152011/152591553-f9c10f4f-b3d9-494c-93a0-981bde0a1ed1.png" width=220>
  <img src="https://user-images.githubusercontent.com/74152011/152591556-3c744d47-4dc0-408d-bdf7-70cbd3c792d7.png" width=220>
</div>
