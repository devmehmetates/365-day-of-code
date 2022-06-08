//
//  UsignFixedGrids.swift
//  NewFeaturesOnSwiftUI
//
//  Created by Mehmet Ateş on 7.06.2022.
//

import SwiftUI

struct UsignFixedGrids: View {
    var body: some View {
        Grid(horizontalSpacing: 20, verticalSpacing: 20) {
            GridRow {
                Image(systemName: "xmark")
                Image(systemName: "xmark")
                Image(systemName: "xmark")
            }.foregroundColor(.red)

            GridRow {
                Image(systemName: "circle")
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                Image(systemName: "circle")
            }

            GridRow {
                Image(systemName: "xmark")
                    .foregroundColor(.red)
                Image(systemName: "circle")
                Image(systemName: "circle")
            }
        }
        .font(.largeTitle)
    }
}

struct UsignFixedGrids_Previews: PreviewProvider {
    static var previews: some View {
        UsignFixedGrids()
    }
}
