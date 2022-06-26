//
//  ContentView2.swift
//  LayoutAndGeometry
//
//  Created by Mehmet Ateş on 26.06.2022.
//

import SwiftUI

// MARK: Offset vs position

// MARK: Position
struct ContentView3: View {
    var body: some View {
        Text("Hello, world!")
            .position(x: 100, y: 100)
            .background(.red)
    }
}

// MARK: Offset
struct ContentView2: View {
    var body: some View {
        Text("Hello, world!")
            .offset(x: 100, y: 100)
            .background(.red)
    }
}

// MARK: GeometryReader
struct ContentView4: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("Hello, World!")
                    .frame(width: geo.size.width * 0.9, height: 40)
                    .background(.red)
            }.background(.green)
            
            Text("More text")
            Text("More text")
            Text("More text")
            Text("More text")
            Text("More text")
                .background(.blue)
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView5()
    }
}


struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct ContentView5: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}
