# Day 31 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day30-31-2"> Project-B </a>

## Auto-Constraint

### Subjects

+ Auto Layout metrics and priorities: constraints(withVisualFormat:)
+ Auto Layout anchors
+ Wrap up

## Auto Layout metrics and priorities: constraints(withVisualFormat:)
```swift
let metrics = ["labelHeight" : 88]
view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
```

## Auto Layout anchors
```swift
var previous : UILabel?
for label in [label1, label2, label3, label4, label5]{
    label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    label.heightAnchor.constraint(equalTo: view.heightAnchor ,multiplier: 0.17 ,constant: 0).isActive = true

    if let previous = previous {
        label.topAnchor.constraint(equalTo: previous.bottomAnchor,constant: 10).isActive = true
    } else{
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0).isActive = true
    }
    previous = label
}
```

## Wrap up

### Try replacing the widthAnchor of our labels with leadingAnchor and trailingAnchor constraints, which more explicitly pin the label to the edges of its parent.
```swift
label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
```

### Once you’ve completed the first challenge, try using the safeAreaLayoutGuide for those constraints. You can see if this is working by rotating to landscape, because the labels won’t go under the safe area.

```swift
label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
```

### Try making the height of your labels equal to 1/5th of the main view, minus 10 for the spacing. This is a hard one, but I’ve included hints below!
```swift
label.heightAnchor.constraint(equalTo: view.heightAnchor ,multiplier: 0.17 ,constant: 0).isActive = true
```
