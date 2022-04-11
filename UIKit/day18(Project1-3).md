# Day 18 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day16-18"> Project </a>

## Begin to the iOS

## Subjects

+ Wrap Up
+ Challenge

## Challenge
In your main table view, show the image names in sorted order, so “nssl0033.jpg” comes before “nssl0034.jpg”.

```swift
pictures.sort() // This is very easy because swift provides a list sorting feature
```

Rather than show image names in the detail title bar, show “Picture X of Y”,<br>
where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.

```swift
// I added that on my detailview-controller
var count : Int = 0
var selectedIndex : Int = 0

// And this is how I set the text of my detail view
title = "Picture \(selectedIndex + 1) of \(count)"
```
```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
        
        vc.selectedImage = pictures[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
        // Here I have sent the number of elements of the list and the index of the selected image to the other page.
        vc.count = self.pictures.count
        vc.selectedIndex = indexPath.row
    }
}
```



## Result

<img src="https://user-images.githubusercontent.com/74152011/149992453-2500da21-048a-4bb1-8d8e-e91971fdb658.png" width=355> <img src="https://user-images.githubusercontent.com/74152011/149992282-9dd4b718-3cb3-44bf-9402-b47bd0e30489.png" width=355>
