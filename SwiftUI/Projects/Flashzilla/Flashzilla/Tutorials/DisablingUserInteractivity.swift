//
//  DisablingUserInteractivity.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 19.06.2022.
//

import SwiftUI

struct DisablingUserInteractivity: View {
    var body: some View {
        NavigationView{
            Form{
                NavigationLink(destination: TransitiveGestures()){
                    Text("Transitive Gestures")
                }
                NavigationLink(destination: DetectSpacingAndGesture()){
                    Text("Detect Spacing")
                }
            }.navigationTitle("DisablingUserInterfaceActivity")
        }
    }
}

struct DisablingUserInteractivity_Previews: PreviewProvider {
    static var previews: some View {
        DisablingUserInteractivity()
    }
}

private struct TransitiveGestures: View{
    @State private var disableState: Int = 0
    
    var body: some View{
        VStack{
            Text(disableState == 0 ? "Rectangle ignored" : "Circle ignored")
            Text("Button Log: \(disableState == 0 ? "Circle tapped!" : "Rectangle tapped!")")
            
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Rectangle tapped!")
                    }

                if disableState == 0{
                    Circle()
                        .fill(.red)
                        .frame(width: 300, height: 300)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            print("Circle tapped!")
                        }
                }else{
                    Circle()
                        .fill(.red)
                        .frame(width: 300, height: 300)
                        .onTapGesture {
                            print("Circle tapped!")
                        }
                        .allowsHitTesting(false)
                }
            }
            Button("Change state"){
                if disableState == 0{
                    disableState = 1
                }else{
                    disableState = 0
                }
            }
        }
    }
}

private struct DetectSpacingAndGesture: View{
    var body: some View{
        VStack{
            Text("Spacing not detected")
            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }.padding()
            .onTapGesture {
                print("VStack tapped!")
            }.overlay(RoundedRectangle(cornerRadius: 10).stroke())
                
            Text("Spacing detected")
            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }.padding()
            .contentShape(Rectangle())
            .onTapGesture {
                print("VStack tapped!")
            }.overlay(RoundedRectangle(cornerRadius: 10).stroke())
        }

    }
}
