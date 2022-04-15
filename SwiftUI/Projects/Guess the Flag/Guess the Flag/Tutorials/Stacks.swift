//
//  Stacks.swift
//  Guess the Flag
//
//  Created by Mehmet Ateş on 15.04.2022.
//

import SwiftUI

struct Stacks: View {
    var body: some View {
        Form{
            VStack(alignment: .trailing, spacing: 20){ // Vertical Stack. Spacing for between content. Contents are aligned from the right to the left (because choice is trailing).
                Text("Loooooong Text")
                Text("Short Text")
                Spacer() // Send content top
            }
            
            HStack(alignment: .top, spacing: 20){ // Horizontal Stack. Spacing for between content
                Text("Hello, World!")
                Text("A\nmultiline Text")
                Spacer() // Send content left
            }
            
            ZStack(alignment: .leading){ // Stack for Z positions.
                Text("I'm behind you.")
                Text("Wow")
            }
            
            // A little challenge: Try placing several horizontal stacks inside a single vertical stack – can you make a 3x3 grid?
                VStack{
                    HStack{
                        Color.red
                        Color.blue
                        Color.green
                    }
                    HStack{
                        Color.red
                        Color.blue
                        Color.green
                    }
                    HStack{
                        Color.red
                        Color.blue
                        Color.green
                    }
                }
                // Or
                HStack{
                    VStack{
                        Color.red
                        Color.red
                        Color.red
                    }
                    VStack{
                        Color.blue
                        Color.blue
                        Color.blue
                    }
                    VStack{
                        Color.green
                        Color.green
                        Color.green
                    }
                }
            
        }
    }
}

struct Tutorials_Previews: PreviewProvider {
    static var previews: some View {
        Stacks()
    }
}
