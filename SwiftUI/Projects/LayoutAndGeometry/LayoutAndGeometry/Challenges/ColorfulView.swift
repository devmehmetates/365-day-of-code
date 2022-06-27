//
//  ColorfulView.swift
//  LayoutAndGeometry
//
//  Created by Mehmet Ateş on 27.06.2022.
//

import SwiftUI

struct ColorfulView: View {
    var body: some View {
        GeometryReader { fullView in
            ScrollView{
                ForEach(0..<30, id: \.self){ number in
                    VStack{
                        GeometryReader{ innerGero in
                            let maxY = innerGero.frame(in: .global).maxY
                            let hue = (maxY - 100) / 1000
                            Text((number + 1).formatted())
                                .frame(width: fullView.size.width, height: 50, alignment: .center)
                                .background(Color(hue: hue, saturation: 0.5, brightness: 1))
                                .position(x: fullView.frame(in: .global).midX, y: 25)
                                
                        }.frame(height: 50)
                    }
                }
                
            }
        }
    }
}

struct ColorfulView_Previews: PreviewProvider {
    static var previews: some View {
        ColorfulView()
    }
}
