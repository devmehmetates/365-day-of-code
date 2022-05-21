//
//  Utils.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 21.05.2022.
//

import Foundation
import SwiftUI

extension Double{
    var responsiveW: Double { return (UIScreen.main.bounds.size.width * self) / 100}
    var responsiveH: Double { return (UIScreen.main.bounds.size.height * self) / 100}
}
