//
//  GridLayout.swift
//  Moonshot
//
//  Created by Mehmet Ateş on 3.05.2022.
//

import SwiftUI

struct GridLayout: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)),
    ]
    
    var body: some View {
        NavigationView{
            Form{
                NavigationLink{
                    VGrid(layout: layout)
                } label: {
                    Text("VGrid")
                }
                NavigationLink{
                    HGrid(layout: layout)
                } label: {
                    Text("HGrid")
                }
            }.navigationTitle("Grids")
        }
    }
}

struct GridLayout_Previews: PreviewProvider {
    static var previews: some View {
        GridLayout()
    }
}


struct HGrid: View{
    var layout: [GridItem]
    
    var body: some View{
        ScrollView(.horizontal){
            LazyHGrid(rows: layout){
                ForEach(0..<1000){
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct VGrid: View{
    var layout: [GridItem]
    
    var body: some View{
        ScrollView(){
            LazyVGrid(columns: layout){
                ForEach(0..<1000){
                    Text("Item \($0)")
                }
            }
        }
    }
}
