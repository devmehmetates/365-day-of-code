# Day 39 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day39-41"> Project </a>

## Async, DispatchQueue, GCD

## Subjects

+ Why is locking the UI bad?
+ GCD 101: async()
+ Back to the main thread: DispatchQueue.main
+ Easy GCD using performSelector(inBackground:)

## GCD 101: async()
Now this code is running in the background.

```swift
DispatchQueue.global(qos: .userInitiated).async {
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self.parse(json: data)
            return
        }
    }
}
```

## Back to the main thread: DispatchQueue.main
Now the thread is running until this code is finished.
```swift
DispatchQueue.main.async {
    self.tableView.reloadData()
}
```

## Easy GCD using performSelector(inBackground:)
It's kind of easy to use

```swift
performSelector(inBackground: #selector(fetchJSON), with: nil)
@objc func fetchJSON() {
    let urlString: String

    if navigationController?.tabBarItem.tag == 0 {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    } else {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    }

    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
        }
    }

    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
}
```

## Summary
To understand this issue, we need to think logically instead of writing code. Because threads are important subjects.Because they are a bit complicated and can cause crashes and crashes if misused. As I have used before, I usually work in the main thread. Async code run sequentially, which allows me to control the order of operations. 

We will get data and we are trying to print the data on the screen before the data comes. The result will be a blank screen.<br>
If we run the thread async and say wait to get the data first. My screen will be blank for a while, but then our data will be correctly printed on the screen.

We do not know when the data will arrive. And we need to get that under control.




## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">










