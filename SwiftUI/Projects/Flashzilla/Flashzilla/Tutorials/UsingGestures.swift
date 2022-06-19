//
//  UsingGestures.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 19.06.2022.
//

import SwiftUI

struct UsingGestures: View {
    var body: some View {
        NavigationView{
            Form{
                NavigationLink(destination: UsingTapGestures()){
                    Text("Tab Gestures")
                }
                NavigationLink(destination: UsingMagnificationGesture()){
                    Text("Magnification Gesture")
                }
                NavigationLink(destination: UsingRotationGesture()){
                    Text("Rotation Gesture")
                }
                NavigationLink(destination: GestureExamples()){
                    Text("Example View")
                }
            }.navigationTitle("Gestures")
        }
    }
}

struct UsingGestures_Previews: PreviewProvider {
    static var previews: some View {
        UsingGestures()
    }
}

private struct UsingTapGestures: View{
    var body: some View{
        ScrollView{
            VStack(spacing: 50){
                Text("Tap Gesture")
                    .onTapGesture(count: 2) {
                        print("Double tapped!")
                    }
                
                Text("Long Tap Gesture")
                    .onLongPressGesture {
                        print("Long pressed!")
                    }
                
                Text("Long Tap Gesture, Min: 2 second")
                    .onLongPressGesture(minimumDuration: 2) {
                        print("Long pressed!")
                    }
                
                Text("Long Press Changes")
                    .onLongPressGesture(minimumDuration: 1) {
                        print("Long pressed!")
                    } onPressingChanged: { inProgress in
                        print("In progress: \(inProgress)!")
                    }
                
                VStack {
                    Text("Parent Gesture")
                        .onTapGesture {
                            print("Text tapped")
                        }
                }
                .onTapGesture {
                    print("VStack tapped")
                }
                
                VStack {
                    Text("High Priority Gesture")
                        .onTapGesture {
                            print("Text tapped")
                        }
                }
                .highPriorityGesture(
                    TapGesture()
                        .onEnded { _ in
                            print("VStack tapped")
                        }
                )
                
                VStack {
                    Text("Simultaneous Gesture")
                        .onTapGesture {
                            print("Text tapped")
                        }
                }
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            print("VStack tapped")
                        }
                )
            }
        }
    }
}

private struct UsingMagnificationGesture: View{
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0

    var body: some View {
        Text("Magnification Gesture")
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        currentAmount = amount - 1
                    }
                    .onEnded { amount in
                        finalAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

private struct UsingRotationGesture: View{
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero

    var body: some View {
        Text("Rotation Gesture")
            .rotationEffect(currentAmount + finalAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        currentAmount = angle
                    }
                    .onEnded { angle in
                        finalAmount += currentAmount
                        currentAmount = .zero
                    }
            )
    }
}

private struct GestureExamples: View{
    @State private var offset = CGSize.zero
    @State private var isDragging = false

    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }

        let combined = pressGesture.sequenced(before: dragGesture)

        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

