# Day 42 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day42-44"> Project </a>

## Developing on UICollectionView

## Subjects

+ Set-Up
+ Designing UICollectionView cells
+ UICollectionView data sources


!! I have to skip the first two issues. Because these topics were made on the story board and can only be accessed in the project.

## UICollectionView data sources
We did almost the same things here, like the tableview we did before.
```swift
...
override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else{
        fatalError("The cell unable")
    }
    cell.imageView.image = UIImage.init(systemName: "star")
    cell.name.text = "Star"
    return cell

}
```
That is all. Set the number of cells and assign the cells to the view by id. But there is a difference here. Exactly this line.

```swift
guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else{
    fatalError("The cell unable")
}
```
We've never used guard let before. so why now? The main purpose is very simple. We are trying to create cells in the cocoa touch class we have determined. This is the PersonCell class, as you might guess. Does the code mean does the cell belong to this class? If it doesn't belong, crash the app. Thus, as long as our application is running, we will be sure of the class of these cells.

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

