//
//  CustomPaths.swift
//  SwiftUIDrawing
//
//  Created by Mehmet Ateş on 7.05.2022.
//

import SwiftUI

struct CustomPaths: View {
    var body: some View {
        VStack{
            Path { path in
                path.move(to: CGPoint(x: 200, y: 100))
                path.addLine(to: CGPoint(x: 100, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 300))
                path.addLine(to: CGPoint(x: 200, y: 100))
            }.stroke(.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            
            Path { path in
                path.move(to: CGPoint(x: 50, y: 100))
                path.addLine(to: CGPoint(x: 50, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 300))
                path.addLine(to: CGPoint(x: 300, y: 100))
                path.addLine(to: CGPoint(x: 50, y: 100))
            }.stroke(.red, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
        }
        
    }
}

struct CustomPaths_Previews: PreviewProvider {
    static var previews: some View {
        CustomPaths()
    }
}
