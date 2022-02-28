# Day 59 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day59-Challenge"> Project </a>

##  Project1 + Project7

+ Challenge

## Challenge
Challenge subject was so long for explain. Please check it out <a href="https://www.hackingwithswift.com/guide/6/3/challenge">here</a>.

But to summarize, read json file, join tables and consolidate codable capabilities.

## How to do this?
First, I was create a dummy data in my project folder. And after, I need the read this file.
```swift
private func readLocalFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
    } catch {
        print(error)
    }

    return nil
}
```
We was learned this code part. Look folder's files on folder path. And find our json file. After, we need parse this file.

```swift
private func parse(jsonData: Data) {
    do {
        let decodedData = try JSONDecoder().decode(DataModel.self,
                                                   from: jsonData)
        self.countries = decodedData.data
    } catch {
        print("decode error")
    }
}
```
Let's parse. Actually this is so basic but sometimes can be complex. Because important section is not here. 

```swift
class DataModel: Codable{
    var data: [CountryModel]
}
```
This is my codeable data model. If this file was not codeable, parse will do nothing. So the model must fit perfectly into the file.

Let's review application data.
```json
{
    "data": [
        {
            "name": "USA",
            "data": [
                {
                    "title": "Support",
                    "desc": "No war"
                },
                {
                    "title": "Help",
                    "desc": "To Ukraine"
                }
            ]
        },
        {
            "name": "Ukraine",
            "data": [
                {
                    "title": "War",
                    "desc": "No war"
                }
            ]
        },
        {
            "name": "Turkey",
            "data": [
                {
                    "title": "Support",
                    "desc": "No war"
                }
            ]
        }

    ]
}
```
Our data keeps a list of country objects, our countries name and a list of news objects. As you can see it is a chain structure. But the parse sets it all apart for us. As long as our models fit, of course.

This means that we need to set up a chain as too view. For this, you need to take a look at the storyboard part, but in summary, the following code helps us.
```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "CountryNews") as? CountryTableViewController else{ return }
    vc.countryNews = countries[indexPath.row].data
    vc.title = countries[indexPath.row].name
    navigationController?.pushViewController(vc, animated: true)
}
```
I have a cocoa Touch class for the pages I created on the Storyboard. This changes according to the page I will redirect, so this code should change on the news page. But its logic is to send objects from one page to another page.

I don't want to prolong it and tire you out. These explanations are enough to understand the project. Happy coding :)
## Great Work :)

<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="700" height="500"/>

