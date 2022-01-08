# Day 8 Extra 

## SwiftUI Login Template 📖
Button and login process that changes according to the situation during the login process

## Button 🔨
```swift
import SwiftUI

struct CustomProgressButton: View {
    @Binding var processRun : Bool 
    @Binding var processComplated: Bool
    var title : String
    var processTitle : String
    var process : () -> Void
    var buttonColor : Color
    
    var body: some View {
        VStack{
            if processRun{
                Button(action: self.process) {
                    HStack{
                        ProgressView().padding(.horizontal,2)
                        Text(self.processTitle)
                    }.padding(.vertical,12)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .background(RoundedRectangle(cornerRadius: 30).stroke())
                }.foregroundColor(self.buttonColor.opacity(0.5))
                .disabled(true)
            }else{
                Button(action: self.process) {
                    Text(self.title)
                        .padding(.vertical,12)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .background(RoundedRectangle(cornerRadius: 30).stroke())
                }.foregroundColor(self.buttonColor)
            }
        }   
    }
}
```

## Bonded Page 🔨
```swift
import SwiftUI

struct AnotherPage : View{
    @State private var processRun = false
    @State private var processComplated = false
    var body: some View{
        VStack{
            CustomProgressButton(processRun: self.$processRun,
                                 processComplated: self.$processComplated,
                                 title: "Giriş Yap",
                                 processTitle: "Giriş Yapılıyor",
                                 process: {
                                    self.processRun.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        self.processComplated.toggle()
                                    }
            }, buttonColor: .purple).fullScreenCover(isPresented: self.$processComplated) {
                VStack{
                    Text("You are logged")
                    Button {
                        self.processComplated.toggle()
                        self.processRun.toggle()
                    } label: {
                        Text("Log Out")
                    } 
                }
            }
        }
    }
}
```

### Output 📱
Now let's see how this code looks like.



https://user-images.githubusercontent.com/74152011/148647033-eddef43e-0aab-4266-b549-60371901b2f9.mov



