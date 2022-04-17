//
//  Challenge.swift
//  ViewsAndModifiers
//
//  Created by Mehmet Ateş on 18.04.2022.
//

import SwiftUI

struct Challenge: View {
    var body: some View {
        Text("Deneme")
            .titleExtension()
    }
}

struct Challenge_Previews: PreviewProvider {
    static var previews: some View {
        Challenge()
    }
}


struct TitleSytle: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.blue)
            
    }
}

extension View{
    func titleExtension() -> some View{
        modifier(TitleSytle())
    }
}
