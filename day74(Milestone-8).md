# Day 74 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day66-Challenge/Day74-Challenge"> Project </a>

## iOS note app clone

## Challenge.
Hello again. Maybe it is the first application that I have used all the information that will be useful to me so far. Now I will summarize what we are doing and share small codes. The project is yours.

+ First of all, we have to arrange the things we need. So the page with 2 navigator controls.
+ The first will be the tableview controller. The second is a normal view controller. I will attach a picture for each of their designs.
+ We are using userdefaults in our project. For this application, we have to use any method like this because it will not be healthy. We don't have a backend service
+ When the application is opened, our recorded notes are taken, sorted and the table is filled. And table elements can of course be deleted. All you have to do is swipe. It also has a refresh feature.
+ Apart from this, there is a new annotation button in our toolbar. This pushes us to a new page. This is our edit page
+ This page that I use in common is filled if the table item is clicked, otherwise it comes blank. Of course, since our aim is imitation, we need to simulate it as much as possible. 
+ We don't need the registration button. The backspace does this for us. That way, our notes don't get lost when we accidentally come back.
+ I have another toolbar button on our edit screen.
+ This note allows us to share the part we took. Fast and effective.
+ That's enough information. I leave you alone with the codes and images of the application :)

## Codes that may be useful

### Codeable objects
```swift
class Note: NSObject, Codable {
    var id: Int
    var title: String
    var detail: String
    
    init (id: Int, title : String, detail : String){
        self.id = id
        self.title = title
        self.detail = detail
    }
}
```

### For toolbar button
```swift
navigationController?.isToolbarHidden = false

let addNote = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .done, target: self, action: #selector(addNote))

addNote.tintColor = UIColor.systemOrange
let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

toolbarItems = [spacer,addNote]
```

### Is the note old?
```swift
let isNoteNew = self.notes?.first(where: { myNote in
    myNote.id == thisNote.id
})
```

## Images

<div>
  
  <img src="https://user-images.githubusercontent.com/74152011/158447037-31c24ef9-9a9f-4236-88e1-67ec3a763a67.png" width=255>
  <img src="https://user-images.githubusercontent.com/74152011/158447010-2c208deb-8d11-4d8f-8cee-20630612c457.png" width=255>
  <img src="https://user-images.githubusercontent.com/74152011/158447027-62981e24-7c0d-451c-9917-943e61aa16a3.png" width=255>
  <img src="https://user-images.githubusercontent.com/74152011/158447018-6e772bfd-f1bc-4fef-8628-b956a6c8b0fb.png" width=255>
  
</div>

## Great Work :)
<img src="https://c.tenor.com/AZdWIW_F0McAAAAC/confetti-celebration.gif" width="400" height="250"/>

