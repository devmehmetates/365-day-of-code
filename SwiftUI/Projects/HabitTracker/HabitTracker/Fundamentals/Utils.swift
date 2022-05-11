//
//  Utils.swift
//  HabitTracker
//
//  Created by Mehmet Ateş on 11.05.2022.
//

import Foundation
import UIKit

extension Double{
    var responsiveW: Double { return (UIScreen.main.bounds.size.width * self) / 100}
    var responsiveH: Double { return (UIScreen.main.bounds.size.height * self) / 100}
}
