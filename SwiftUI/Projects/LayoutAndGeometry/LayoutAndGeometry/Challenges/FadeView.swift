//
//  FadeView.swift
//  LayoutAndGeometry
//
//  Created by Mehmet Ateş on 27.06.2022.
//

import SwiftUI

struct FadeView: View {
    var body: some View {
        GeometryReader { fullView in
            let viewHeight = fullView.size.height
            ScrollView{
                ForEach(0..<30, id: \.self){ number in
                    GeometryReader{ innerGero in
                        let maxY = innerGero.frame(in: .global).maxY
                        let opacity = ((maxY / 2) - (viewHeight * 0.01)) / 150
                        Text("Number")
                            .frame(width: fullView.size.width, height: 50, alignment: .center)
                            .background(.red)
                            .opacity(opacity)
                    }.frame(height: 50, alignment: .center)
                }
            }
        }
    }
}

struct FadeView_Previews: PreviewProvider {
    static var previews: some View {
        FadeView()
    }
}
