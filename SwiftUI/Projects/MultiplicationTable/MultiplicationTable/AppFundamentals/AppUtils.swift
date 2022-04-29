//
//  AppUtils.swift
//  MultiplicationTable
//
//  Created by Mehmet Ateş on 29.04.2022.
//

import Foundation
import UIKit

extension Double{
    func responsizeWidth () -> Double { return (self * UIScreen.main.bounds.width / 100) }
    func responsizeHeight () -> Double { return (self * UIScreen.main.bounds.height / 100) }
}
