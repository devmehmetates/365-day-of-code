# Day 73 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day72-73/Day72-73"> Project </a>

## Developing on Notifications

## Subjects

+ Wrap Up
+ Challenges

## Challenges

+ Update the code in didReceive so that it shows different instances of UIAlertController depending on which action identifier was passed in.
+ For a harder challenge, add a second UNNotificationAction to the alarm category of project 21. Give it the title “Remind me later”, and make it call scheduleLocal() so that the same alert is shown in 24 hours. (For the purpose of these challenges, a time interval notification with 86400 seconds is good enough – that’s roughly how many seconds there are in a day, excluding summer time changes and leap seconds.)
+ And for an even harder challenge, update project 2 so that it reminds players to come back and play every day. This means scheduling a week of notifications ahead of time, each of which launch the app. When the app is finally launched, make sure you call removeAllPendingNotificationRequests() to clear any un-shown alerts, then make new alerts for future days.

## Update the code in didReceive so that it shows different instances of UIAlertController depending on which action identifier was passed in.
```swift
func showAlert(title: String?, message: String?){
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))

    present(ac, animated: true)
}
```
First I wrote a little alert function. 

```swift
switch response.actionIdentifier {
    case UNNotificationDefaultActionIdentifier:
        showAlert(title: "This is a default identifier", message: "Not special! Sorry :(")

    case "show":
        showAlert(title: "This is show more button!", message: "Here is the your notification information;\n\(customData)")
...
```
Then I ran this function by customizing it for the events that will happen when the buttons are clicked.

## For a harder challenge, add a second UNNotificationAction to the alarm category of project 21. Give it the title “Remind me later”, and make it call scheduleLocal() so that the same alert is shown in 24 hours. (For the purpose of these challenges, a time interval notification with 86400 seconds is good enough – that’s roughly how many seconds there are in a day, excluding summer time changes and leap seconds.)
```swift
func registerCategories() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self

    let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
    let remind = UNNotificationAction(identifier: "remind", title: "Remind me later...", options: .foreground) // Add here
    let category = UNNotificationCategory(identifier: "alarm", actions: [show, remind], intentIdentifiers: [])

    center.setNotificationCategories([category])
}
```

```swift
case "show":
    showAlert(title: "This is show more button!", message: "Here is the your notification information;\n\(customData)")

// and add here
case "remind":
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false)
    let secondContent = UNMutableNotificationContent()
    secondContent.title = "Reminder!!"
    secondContent.body = response.notification.request.content.body
    secondContent.categoryIdentifier = response.notification.request.content.categoryIdentifier
    secondContent.userInfo = response.notification.request.content.userInfo
    secondContent.sound = UNNotificationSound.default
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: secondContent, trigger: trigger)
    center.add(request)
```
Good challenge. We simply make the notification trigger a new notification with a new button. The codes already do exactly that.

## And for an even harder challenge, update project 2 so that it reminds players to come back and play every day. This means scheduling a week of notifications ahead of time, each of which launch the app. When the app is finally launched, make sure you call removeAllPendingNotificationRequests() to clear any un-shown alerts, then make new alerts for future days.

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    registerNotification()
...
```
Now I had to think of some logic first. I ran the registration process each time the app was opened. This gave me this;
```swift
func registerNotification(){
    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        if granted {
            print("Everything is okay")
            self.setNotification()
        } else {
            print("oh no! :(")
        }
    }
}
```
If the user has already allowed notifications, this function directly executes the allowed code. And the warning is only shown once. So exactly what we want. So what should we do every day to be summoned to the game?

```swift
func setNotification(){
    center.removeAllPendingNotificationRequests()

    let content = UNMutableNotificationContent()
    content.title = "Come back! We miss you."
    content.body = "Hey! You wanna a quick game! I know. Come!"
    content.categoryIdentifier = "reminder"
    content.userInfo = ["gamename": "flag game"]
    content.sound = UNNotificationSound.default

    let components = Calendar.current.dateComponents([.day], from: Date.now)
    var dateComponents = DateComponents()

    dateComponents.day = (components.day ?? 0) + 1
    dateComponents.hour = 20
    dateComponents.minute = 30
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)

    print("Trigger Date: \(dateComponents)")

}
```
This code is here for it. All pending notifications are removed as soon as the user enters the game. This means this. The user logged into the game yesterday and a notification was triggered for the next evening. But the user entered the game before the notification. Even if he leaves 5 minutes before the notification, he will receive a notification saying we miss him. This is how we solved this undesirable situation. Then what? What if the user triggers an alert for tomorrow every time he logs in? And if the old triggers are cleared every time it enters. He will receive a notification for the day he does not enter the game. And that's exactly what is wanted!

### Note
```swift
dateComponents.day = (components.day ?? 0) + 1
dateComponents.hour = 20
dateComponents.minute = 30
let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
center.add(request)
```

If you put this code in a for loop and run it 7 times and assign the number of days to the value of the loop, So;
```swift
for plusDay in 1...7{
    dateComponents.day = (components.day ?? 0) + plusDay
    dateComponents.hour = 20
    dateComponents.minute = 30
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
}
```
You have the user trigger notifications for the whole week on every login. Of course this really doesn't always work because there are very specific cases. That's why you have to be careful!

## Great Work :)

<img src="https://global-uploads.webflow.com/5e0ac69bad6badc677c5db21/6136efdd077934476ce23eb7_coder.gif" width="350" height="200"/>


