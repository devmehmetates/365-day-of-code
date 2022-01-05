# Day 4 Extra 
These files won't be every day !! Because it's like research

## Begin to Unit tests 📖
Unit tests help you make sure that your application is logically correct.

## Prepare 🔨
Before we can test it, we have to build a structure. I coded a little game for myself.
```swift
class RaceGame {
    let player1 = "Name"
    let player2 = "Name2"
    var p1score = 0
    var p2score = 0
    var tour = 0
    var result = GameResult.inGame
    
    
    func getPoint(player : String) -> GameResult{
        if (tour < 9){
            switch player{
            case "Name":
                self.p1score += 1
            case "Name2":
                self.p2score += 1
            default:
                print("Do nothing")
            }
            tour += 1
        }else{
            
            if self.p1score > self.p2score{
                result = GameResult.finised(winner: self.player1)
            }else if self.p2score > self.p1score{
                result = GameResult.finised(winner: self.player2)
            }
        }
        return result
    }
}


enum GameResult {
    case inGame
    case finised(winner : String)
}
```

## Test 🧪
The first step was import the target content
```swift
import XCTest
@testable import BeginToUnitTest // Of course testable
```
Then we created our own tests by modifying our sample test class.
```swift
class BeginToUnitTestTests: XCTestCase {
    var sut: RaceGame! // Ready the test class
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RaceGame()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
}
```
We write all of these tests in the above class.
```swift
    func testGameThrow() throws { // Name of test functions must start with test. Otherwise, they are not tested.
        // 1. Did the game throw any results
        let player1 = sut.player1
        var result = sut.result
        for _ in 0...9{
            result = sut.getPoint(player: player1)
        }
        XCTAssertNotNil(result)
    }
    func testGameResult() throws {
        // 2. The Game result is correct ?
        let player1 = sut.player1
        var result  = sut.result
        for _ in 0...10{
            result = sut.getPoint(player: player1)
        }
        var testResult = false
        switch result {
            case .inGame:
                testResult = false
            case .finised(let winner):
                testResult = (winner == sut.player1)
        }
        XCTAssert(testResult, "Game not works true")
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
```

## Result ❓
As you can see, all the tests were successful.
```console
Test Suite 'All tests' started at 2022-01-04 17:47:13.551
Test Suite 'BeginToUnitTestTests.xctest' started at 2022-01-04 17:47:13.553
Test Suite 'BeginToUnitTestTests' started at 2022-01-04 17:47:13.554
Test Case '-[BeginToUnitTestTests.BeginToUnitTestTests testGameResult]' started.
Test Case '-[BeginToUnitTestTests.BeginToUnitTestTests testGameResult]' passed (0.013 seconds).
Test Case '-[BeginToUnitTestTests.BeginToUnitTestTests testGameThrow]' started.
Test Case '-[BeginToUnitTestTests.BeginToUnitTestTests testGameThrow]' passed (0.005 seconds).
Test Case '-[BeginToUnitTestTests.BeginToUnitTestTests testPerformanceExample]' started.
/Users/mehmetates/Documents/SwiftProject/My Project/BeginToUnitTest/BeginToUnitTestTests/BeginToUnitTestTests.swift:53: Test Case '-[BeginToUnitTestTests.BeginToUnitTestTests testPerformanceExample]' measured [Time, seconds] average: 0.000, relative standard deviation: 121.427%, values: [0.001924, 0.000496, 0.000229, 0.000222, 0.000220, 0.000219, 0.000222, 0.000219, 0.000219, 0.000218], performanceMetricID:com.apple.XCTPerformanceMetric_WallClockTime, baselineName: "", baselineAverage: , polarity: prefers smaller, maxPercentRegression: 10.000%, maxPercentRelativeStandardDeviation: 10.000%, maxRegression: 0.100, maxStandardDeviation: 0.100
Test Case '-[BeginToUnitTestTests.BeginToUnitTestTests testPerformanceExample]' passed (0.454 seconds).
Test Suite 'BeginToUnitTestTests' passed at 2022-01-04 17:47:14.027.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.471 (0.473) seconds
Test Suite 'BeginToUnitTestTests.xctest' passed at 2022-01-04 17:47:14.028.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.471 (0.475) seconds
Test Suite 'All tests' passed at 2022-01-04 17:47:14.028.
	 Executed 3 tests, with 0 failures (0 unexpected) in 0.471 (0.477) seconds
```
