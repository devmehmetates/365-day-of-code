//
//  ScaleView.swift
//  LayoutAndGeometry
//
//  Created by Mehmet Ateş on 27.06.2022.
//

import SwiftUI

struct ScaleView: View {
    var body: some View {
        GeometryReader { fullView in
            ScrollView{
                ForEach(0..<30, id: \.self){ number in
                    VStack{
                        GeometryReader{ innerGero in
                            let maxY = innerGero.frame(in: .global).maxY
                            let customWidth = (maxY / 2.5)
                            Text((number + 1).formatted())
                                .frame(width: customWidth, height: 50, alignment: .center)
                                .background(Rectangle().foregroundColor(.red).shadow(color: .secondary, radius: 1, x: 1, y: 5))
                            
                                .position(x: fullView.frame(in: .global).midX, y: 50)
                                
                        }.frame(height: 50)
                    }
                }
                
            }
        }
    }
}

struct ScaleView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleView()
    }
}
