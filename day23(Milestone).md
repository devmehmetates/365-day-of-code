# Day 23 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day23"> Project </a>

## Developing on UIKit

## Subjects

+ What you learned - Review
+ Key points - What we consider important
+ Challenges

## Key points

### "try" usage

We must use the try keyword correctly to catch errors. Because if an error occurs and we use the wrong try, our application will crash.
<code>try?</code> <code>try!</code> force or allow <br>
If you're sure you won't get an error, force it. If you're not sure, don't force it. Because your code can crash.


### numberOfRowsInSection 
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
}
```
Here is the detail : We want the table to have as many rows as we give, not a certain number of rows.<br>
This gives us exactly the rows we need. Clear!

### dequeueReusableCell and storyboard?.instantiateViewController
These allow us to work the items we created on the storyboard in harmony with our code.<br>
A row or a view controller. Both have an identity. This gives us access.
```swift
let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)

if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
}
```

### Extra - info.plist(Privacy)
Apple places incredible emphasis on user experience and privacy in its new developments.<br>
So much so that if your info.plist doesn't have the required permission, even an auto-generating item will no longer be created.

## Challenges

This time the challenge is an application. Therefore it does not have certain substances<br>
Project link available at the top of the page as usual

## Happy Coding :)

<img src="https://i.giphy.com/media/VbnUQpnihPSIgIXuZv/giphy.webp" width="160" height="200"/>

