//
//  BordersImagePaint.swift
//  SwiftUIDrawing
//
//  Created by Mehmet Ateş on 8.05.2022.
//

import SwiftUI

struct BordersImagePaint: View {
    var body: some View {
        VStack{
            
            Text("Hello World")
                .frame(width: 200, height: 100)
                .border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)
            
            Text("Fade")
                .frame(width: 200, height: 100)
                .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
            
            Capsule()
                .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
                .frame(width: 200, height: 200)
        }
        
        
    }
}

struct BordersImagePaint_Previews: PreviewProvider {
    static var previews: some View {
        BordersImagePaint()
    }
}
