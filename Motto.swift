import Foundation

var complatedDays = [Int]()

func doesTheChallengeContinue(codingToday: Bool, day : Int) -> Bool {
  complatedDays.append(day)
  return codingToday
}

for day in 1...365{
    var challenge = true
    challenge = doesTheChallengeContinue(codingToday:true,day:day)
    if !challenge{
        break
    }
}

// If I don't code one day, the cycle will break and it will never continue again.
