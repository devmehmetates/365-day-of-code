//
//  ScrollingData.swift
//  Moonshot
//
//  Created by Mehmet Ateş on 3.05.2022.
//

import SwiftUI

struct CustomText: View{
    let text: String
    
    var body: some View{
        Text(text)
    }
    
    init(_ text : String){
        print("Creating a new customText")
        self.text = text
    }
}


struct ScrollingData: View {
    var body: some View {
        // MARK: Important note
        /// VStacks and HStacks  are create all contents immediately
        /// But Lazys are not create immediately. This is a performance trick and I think that's important for using big datas on this application.
        
        ScrollView(.horizontal){
            LazyHStack(spacing: 10){
                ForEach(0..<100){
                    Text("Item \($0)")
                        .font(.title)
                }
            }.frame(maxWidth: .infinity)
        }
    }
}

struct ScrollingData_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingData()
    }
}
