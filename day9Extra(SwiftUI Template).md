# Day 8 Extra 

## SwiftUI Set Local Notification And Save Local Storage 📖
Simply set and trigger local notifications. And use local memory.

## Count Buttons 🔨
```swift
import SwiftUI

struct CountNotification : View{
    @Binding var count : Int
    let defaults : UserDefaults
    
    var body: some View{
        HStack{
        
            Button {
                if self.count > 0{
                    self.count -= 1
                }
            } label: {
                Text("-")
                    .font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .background(RoundedRectangle(cornerRadius: 5).stroke().foregroundColor(.primary))
            }
            
            Button {
                self.count += 1
                self.setNotification(count: self.count)
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .background(RoundedRectangle(cornerRadius: 5).stroke().foregroundColor(.primary))
            }
        }.foregroundColor(.red)      
    }
}
```

## Bage Button 🔨
```swift
import SwiftUI

struct BadgeButton : View{
    @Binding var count : Int
    let defaults : UserDefaults
      
    var body: some View{
        VStack{
            Button {
                self.count = 0
                self.defaults.set(count, forKey: "notification")
            } label: {
                ZStack(alignment: .topTrailing){
                    Text("Clear")
                        .foregroundColor(.primary)
                        .font(.title2)
                        .frame(width: 110, height: 50)
                        .background(RoundedRectangle(cornerRadius: 5).stroke().foregroundColor(.primary))
                        
                    ZStack{
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.red)
                        if self.count > 99{
                            Text("+99")
                                .font(.caption2)
                                .foregroundColor(.white)
                        }else{
                            Text(String(self.count))
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                    }.offset(x:10,y:-10)
                        .opacity(self.count != 0 ? 1.0 : 0.0)  
                }
            }
        }
    }
}
```

## Permission Button 🔨
```swift
import SwiftUI

struct GetPermission : View{
    var body: some View{
        Button {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("All set!")
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        } label: {
            Text("Set Permission")
        }
    }
}
```

## Notification Function ⚙️
```swift
func setNotification (count:Int){
    let content = UNMutableNotificationContent()
    content.title = "Notification"
    content.subtitle = "You have a new message"
    content.sound = UNNotificationSound.default

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval((5 + (count * 2))), repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request)
    self.defaults.set(count, forKey: "notification")
}
```


## And Page 🔨
```swift
import SwiftUI

struct BadgeWithNotification: View {
    @State private var count = 0
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack{
            GetPermission()
                .padding(.bottom)
            CountNotification(count:self.$count,defaults: self.defaults)
                .padding(.bottom)
            BadgeButton(count:self.$count,defaults: self.defaults)
                .padding(.top)
        }.onAppear {
            self.count = defaults.integer(forKey: "notification")
        }
    }
}
```


### Output 📱
Now let's see how this code looks like.

<img src="https://user-images.githubusercontent.com/74152011/148684276-33d77501-256e-4e00-8b38-7e1b6c9a1f94.png" width=250><img src="https://user-images.githubusercontent.com/74152011/148684285-a0a9c84c-b7e9-4ca7-b318-89fb0e752a72.png" width=250>
