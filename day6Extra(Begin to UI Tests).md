# Day 6 Extra 

## Begin to Unit tests 📖
Just like unit tests they are made to make sure. Using them, we make sure that the UI components are working correctly.

## Prepare 🔨
Let's code a simple page first. The purpose of the page is ; <br>
Clicking the first two buttons and activating the continue button.
```swift
import SwiftUI

struct ViewTest: View {
    @State private var firstStep = false
    @State private var secondStep = false
    @State private var isDisable = false
    
    func setEnable (){
        if self.firstStep && self.secondStep{
            self.isDisable = true
        }else{
            self.isDisable = false
        }
    }
    
    var body: some View {
        VStack(spacing:10){
            Spacer()
            Text(isDisable ? "Complated" : "Not complated")
            
            Button {
                self.firstStep.toggle()
                self.setEnable()
            } label: {
                Text(firstStep ? "First Step ✔️" : "First Step")
            }
            
            Button {
                self.secondStep.toggle()
                self.setEnable()
            } label: {
                Text(secondStep ? "Second Step ✔️" : "Second Step")
            }
            
            Spacer()
            Button {
                print("Now, you can go!")
            } label: {
                Text("Continue")
            }.disabled(!self.isDisable)
            Spacer()

        }
    }
}
```

### Outputs
Now let's see how this code looks like.

<img src="https://user-images.githubusercontent.com/74152011/148425313-b188a545-feaa-4f60-ae3f-9b43e1d64da4.png" width=325> <img src="https://user-images.githubusercontent.com/74152011/148425325-691699f3-2e10-44fd-8893-e3ccabb3de0b.png" width=325> <img src="https://user-images.githubusercontent.com/74152011/148425332-14db97dc-e969-4a40-89ea-d7e33e9fafc4.png" width=325>


## Test 🧪
Good, our page is ready now we are ready to test.

+ First, let's use the recording feature that xcode provides.
```swift
func testButtons() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["First Step"].tap()
        app.buttons["Second Step"].tap()
        app.buttons["Continue"].tap()
    }
```
And we got a result like this. This is exactly the order we want. But there is nothing to evaluate here

+ Then let's add some controls
```swift
func testButtons() throws {
        let app = XCUIApplication()
        app.launch()
        
        let firstStepButton = app.buttons["First Step"]
        let secondStepButton = app.buttons["Second Step"]
        let continueButton = app.buttons["Continue"]
        
        firstStepButton.tap()
        
        XCTAssertFalse(continueButton.isEnabled) // "continueButton" shouldn't be enabled yet
        
        secondStepButton.tap()
        
        XCTAssertTrue(continueButton.isEnabled) // "continueButton" should be enabled
    }
```
Our goal was to test the activation of the other button after clicking two buttons.
And, yes our tests are successful

## Result ❓
```console
Test Suite 'Selected tests' started at 2022-01-06 21:21:21.101
Test Suite 'BeginToUnitTestUITests.xctest' started at 2022-01-06 21:21:21.104
Test Suite 'BeginToUnitTestUITests' started at 2022-01-06 21:21:21.104
Test Case '-[BeginToUnitTestUITests.BeginToUnitTestUITests testButtons]' started.
    t =     0.00s Start Test at 2022-01-06 21:21:21.106
    t =     0.07s Set Up
    t =     5.70s Tap "First Step" Button
    t =     5.72s     Find the "First Step" Button
    t =     5.88s     Check for interrupting elements affecting "First Step" Button
    t =     5.90s     Synthesize event
    t =     6.08s Find the "Continue" Button
    t =     6.09s Tap "Second Step" Button
    t =     6.10s     Find the "Second Step" Button
    t =     6.11s     Check for interrupting elements affecting "Second Step" Button
    t =     6.12s     Synthesize event
    t =     6.23s Find the "Continue" Button
    t =     6.24s Tear Down
Test Case '-[BeginToUnitTestUITests.BeginToUnitTestUITests testButtons]' passed (6.444 seconds).
Test Suite 'BeginToUnitTestUITests' passed at 2022-01-06 21:21:27.551.
	 Executed 1 test, with 0 failures (0 unexpected) in 6.444 (6.447) seconds
Test Suite 'BeginToUnitTestUITestsLaunchTests' started at 2022-01-06 21:21:27.556
Test Suite 'BeginToUnitTestUITestsLaunchTests' passed at 2022-01-06 21:21:27.557.
	 Executed 0 tests, with 0 failures (0 unexpected) in 0.000 (0.001) seconds
Test Suite 'BeginToUnitTestUITests.xctest' passed at 2022-01-06 21:21:27.557.
	 Executed 1 test, with 0 failures (0 unexpected) in 6.444 (6.454) seconds
Test Suite 'Selected tests' passed at 2022-01-06 21:21:27.559.
	 Executed 1 test, with 0 failures (0 unexpected) in 6.444 (6.458) seconds
```
