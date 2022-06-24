//
//  Extensions.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 24.06.2022.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
