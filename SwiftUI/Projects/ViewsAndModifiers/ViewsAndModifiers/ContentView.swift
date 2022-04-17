//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Mehmet Ateş on 17.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var toggleButtonColor: Bool = false
    
    var body: some View {
        // You should avoid UIKit bindings. The bridge is always dangerous. Destructible!
        // MARK: After first 3 lesson
        
        ScrollView{
            // MARK: 4. Lesson
            Button("Hello, world!") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(.red)
            
            // MARK: 5. Lesson
            // @ViewBuilder var body: Self.Body { get } - almost everything is this
            
            // MARK: 6. Lesson
            // Use short if blocks.(W.T.F - What ? True : False)
            Button("Change me!!"){
                toggleButtonColor.toggle()
            }.foregroundColor(toggleButtonColor ? .red : .blue)
            
            // MARK: 7. Lesson
            // Use enviroment modifiers
            VStack{ // Wrong usage
                Text("Hello World!")
                    .foregroundColor(.red)
                Text("Hello World!")
                    .foregroundColor(.red)
                Text("Hello World!")
                    .foregroundColor(.red)
                Text("Hello World!")
                    .foregroundColor(.red)
            }
            
            VStack{ // True usage
                Text("Hello World!")
                Text("Hello World!")
                Text("Hello World!")
                Text("Hello World!")
            }.foregroundColor(.red)
           
            // MARK: 8.Lesson
            // Go to this view
            Lesson8()
            
            // MARK: 9.Lesson
            // You should split your view for clean and high read status your codes
            
            // MARK: 10.Lesson
            // Go to this view
            Lesson10()
            
            // MARK: 11.Lesson
            GridStack(rows: 4, columns: 4) { row, col in
                HStack {
                    Image(systemName: "\(row * 4 + col).circle")
                    Text("R\(row) C\(col)")
                }
            }
        }
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Lesson8: View{
    var motto1: some View {
        Text("Draco dormiens")
    }
    let motto2 = Text("nunquam titillandus")
    
    var constantSpells: some View {
        VStack {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
    var flexSpells: some View {
        Group {
            Text("Lumos")
            Text("Obliviate")
        }
    }
    
    @ViewBuilder var spells: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    var body: some View{
        VStack{
            motto1
                .foregroundColor(.red)
            motto2
                .foregroundColor(.blue)
            
            constantSpells
            
            HStack{
                flexSpells
            }
            
            spells
        }
    }
}


struct Lesson10: View{
    // This lesson include Title and WaterMark Structs with extensions
    
    var body: some View{
        VStack{
            Text("With Modifier")
                .modifier(Title())
            
            Text("With Extension")
                .titleStyle()
            
            // WaterMark
            Color.red
                .frame(width: 100, height: 100)
                .watermarked(with: "Mehmet ATEŞ")
        }
    }
}

// MARK: Lesson10
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

// MARK: 11.Lesson
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}
