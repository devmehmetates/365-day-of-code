# Day 33 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day33-35"> Project </a>

## Developing on WebKit

## Subjects

+ Set-Up
+ Creating the basic UI: UITabBarController
+ Parsing JSON using the Codable protocol

## Creating the basic UI: UITabBarController
The changes here were made entirely on the storyboard.

## Parsing JSON using the Codable protocol
I am familiar with this subject and this was one of the things I learned when I first started swift.


```swift
import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
```

```swift
import Foundation

struct Petitions: Codable {
    var results: [Petition]
}
```

```swift
var petitions = [Petition]()

override func viewDidLoad() {
    super.viewDidLoad()
    let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"

    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
        }
    }
}

func parse(json: Data) {
    let decoder = JSONDecoder()
    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        self.petitions = jsonPetitions.results
        self.tableView.reloadData()
    }


}

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return petitions.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
    let petition = petitions[indexPath.row]
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text = petition.body
    return cell
}
```
