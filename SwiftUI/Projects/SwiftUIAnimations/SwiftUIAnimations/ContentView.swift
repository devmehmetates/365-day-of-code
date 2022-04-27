//
//  ContentView.swift
//  SwiftUIAnimations
//
//  Created by Mehmet Ateş on 26.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    NavigationLink {
                        Basics()
                    } label: {
                        Text("Basics")
                    }
                    NavigationLink {
                        BindingOnAnimations()
                    } label: {
                        Text("Binding On Animations")
                    }
                    NavigationLink {
                        ModifierStackWithAnimations()
                    } label: {
                        Text("Modifier Stack Controls")
                    }
                } header: {
                    Text("Fundamentals")
                }
                
                Section{
                    NavigationLink {
                        ExplicitAnimations()
                    } label: {
                        Text("Explicit Animations")
                    }
                    NavigationLink {
                        AnimationsAndGestures()
                    } label: {
                        Text("Animations With Gestures")
                    }
                    NavigationLink {
                        ShowAndHideWithTransitions()
                    } label: {
                        Text("Show and Hide Transitions")
                    }
                    NavigationLink {
                        CustomAnimations()
                    } label: {
                        Text("Custom Animations")
                    }
                } header: {
                    Text("Advanced")
                }
                
            }.navigationTitle("Animations")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
