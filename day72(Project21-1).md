# Day 72 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day72-73/Day72-73"> Project </a>

## Developing on Notifications

## Subjects

+ Set-Up
+ Scheduling notifications: UNUserNotificationCenter and UNNotificationRequest
+ Acting on responses

## Scheduling notifications: UNUserNotificationCenter and UNNotificationRequest
Today we are again talking about one of the important but easy topics. Notifications, like almost all apple features, ask the user for permission. Therefore, it is necessary to get permission first and then do the operations if there is permission. So let's get started.

```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
```
We added 2 buttons to our navigation bar. One for permission and the other for notification. Like we said, we have to get permission first. That's how simple it is to get permission.

```swift
@objc func registerLocal() {
    let center = UNUserNotificationCenter.current()

    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        if granted {
            print("Yay!")
        } else {
            print("D'oh")
        }
    }
}
```

If our user has given permission, our other codes will work great.
```swift
@objc func scheduleLocal() {
    let center = UNUserNotificationCenter.current()
    center.removeAllPendingNotificationRequests()

    let content = UNMutableNotificationContent()
    content.title = "Late wake up call"
    content.body = "The early bird catches the worm, but the second mouse gets the cheese."
    content.categoryIdentifier = "alarm"
    content.userInfo = ["customData": "Mehmet"]
    content.sound = UNNotificationSound.default

    var dateComponents = DateComponents()
    dateComponents.hour = 10
    dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
}
```
Yes, this part may seem a little more complicated than the other part. But most of them are optional items and that makes them look too much. Now, to summarize, we define our notification-related features. I think this is pretty obvious. The confusing thing might be the part about history. If we want to send notification based on a specific date we should use this. Here we use the send after a certain time option. And it triggers the notification according to this time.

## Acting on responses
Notification options are available on iOS. We can manage them.

```swift
func registerCategories() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self

    let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
    let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

    center.setNotificationCategories([category])
}
```
This is definitely an identifier specific to this notification right now. It is called with its defined id and determines what will happen. What we're doing in this piece is adding a button.

```swift
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    if let customData = userInfo["customData"] as? String {
        print("Custom data received: \(customData)")

        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("Default identifier")

        case "show":
            print("Show more information…")
            
        default:
            break
        }
    }
    completionHandler()
}
```
Here is what that button will do. As you can see, if identifier show it has a statement. This means our button. and it does a print operation. The if let statement on it is completely related to the notification. We hold information in the unit. and if we have this information, this output is written.

```swift
@objc func scheduleLocal() {
    registerCategories()
...
```
Finally, in order for all this to happen, we need to add this code to our notification trigger function.


## Happy Coding :)
<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

