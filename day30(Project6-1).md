# Day 30 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day30-31"> Project-A </a> <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day30-31-2"> Project-B </a>

## Auto-Constraint

### Subjects

+ Auto Layout in code

## Auto Layout in code
Although it is very easy to add, it really takes a lot of effort. And the storyboard looks better in this regard.
```swift
let label1 = UILabel()
label1.translatesAutoresizingMaskIntoConstraints = false
label1.backgroundColor = .red
label1.text = "These"
label1.sizeToFit()

let label2 = UILabel()
label2.translatesAutoresizingMaskIntoConstraints = false
label2.backgroundColor = .cyan
label2.text = "Are"
label2.sizeToFit()

let label3 = UILabel()
label3.translatesAutoresizingMaskIntoConstraints = false
label3.backgroundColor = .yellow
label3.text = "Some"
label3.sizeToFit()

let label4 = UILabel()
label4.translatesAutoresizingMaskIntoConstraints = false
label4.backgroundColor = .green
label4.text = "Awesome"
label4.sizeToFit()

let label5 = UILabel()
label5.translatesAutoresizingMaskIntoConstraints = false
label5.backgroundColor = .orange
label5.text = "Labels"
label5.sizeToFit()


view.addSubview(label1)
view.addSubview(label2)
view.addSubview(label3)
view.addSubview(label4)
view.addSubview(label5)

let viewsDictionary = ["label1" : label1 , "label2" : label2, "label3" : label3, "label4" : label4 , "label5" : label5]

for label in viewsDictionary.keys{
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
}

view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))

```
