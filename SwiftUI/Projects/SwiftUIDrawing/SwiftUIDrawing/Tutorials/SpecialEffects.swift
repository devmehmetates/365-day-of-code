//
//  SpecialEffects.swift
//  SwiftUIDrawing
//
//  Created by Mehmet Ateş on 9.05.2022.
//

import SwiftUI

struct SpecialEffects: View {
    var body: some View {
        NavigationView{
            Form {
                NavigationLink("BlendMode Example") {
                    BlendModesExamples()
                }
                NavigationLink("MultiBlendMode Merge Example") {
                    MultiBlendModeMergeExample()
                }
                NavigationLink("Blur and Saturation") {
                    BlurAndSaturationExample()
                }
            }
        }
    }
}

struct SpecialEffects_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffects()
    }
}


struct BlendModesExamples: View{
    var body: some View{
        Form{
            Section{
                ZStack {
                    Image("Example")
                        .resizable()
                        .scaledToFill()
                    
                    Rectangle()
                        .fill(.red)
                        .blendMode(.multiply)
                }
            } footer: {
                Text("Usage with Zstack and blend mode")
            }
            
            Section{
                Image("Example")
                    .resizable()
                    .scaledToFill()
                    .colorMultiply(.red)
            } footer: {
                Text("Usage with colorMultiply")
            }
        }.navigationTitle("BlendModes")
    }
}


struct MultiBlendModeMergeExample: View{
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(.red)
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(.green)
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(.blue)
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}


struct BlurAndSaturationExample: View{
    @State private var amount = 0.0
    
    var body: some View{
        VStack{
            Image("Example")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
        
    }
}
