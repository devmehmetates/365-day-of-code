//
//  CountDone.swift
//  CountDown App
//
//  Created by Mehmet Ateş on 13.01.2022.
//

import Foundation

class CountProcess {
    let countList : [String : Int] = [
        "YRS" : 31_556_926,
        "DAY" : 86_400,
        "HRS" : 3_600,
        "MIN" : 60,
        "SEC" : 0,
    ]
    func isCountDone(which count : String , for time : Int) -> Bool {
        return self.countList[count]! > time
    }
    
    func CountVisual(count : Int) -> String{
        if count > 9{
            return String(count)
        }else{
            return "0" + String(count)
        }
    }
}
