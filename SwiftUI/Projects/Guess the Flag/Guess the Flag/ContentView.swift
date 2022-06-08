//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Mehmet Ateş on 15.04.2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    
    // For rotation effect
    @State private var selectedFlag: Int = -1
    @State private var rotationDegree: CGFloat = 0.0
    
    // Game counter
    @State private var roundSequence: Int = 0
    
    // Base game properties
    @State private var userScore: Int = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    // For alert
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    // Question limit
    private let roundNumber = 8
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    // MARK: UI
    var body: some View {
        ZStack {
            
            // Background colors and shapes
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            // Front of the view
            VStack {
                Spacer()
                
                // Game title
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundColor(.white)
                
                // Main block of the game
                VStack(spacing:15) {
                    VStack {
                        
                        // Title and correct answer labels
                        Text("Tab the Flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundColor(.secondary)
                        
                        // Flag buttons
                        ForEach(0..<3) { number in
                            Button {
                                self.selectedFlag = number // for selecting the tapped flag
                                flagTapped(number)
                            } label: {
                                FlagImage(image: Image(countries[number]), selectedFlag: self.$selectedFlag, number: number, rotationDegree: self.$rotationDegree)
                                    .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                            }
                        }
                    }.frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Spacer()
                Spacer()
                
                // Score label
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }.padding()
        }.alert(scoreTitle, isPresented: $showingScore) { // Alert is here
            if roundSequence == roundNumber{ // If the game was over
                Button("Restart", action: restartGame)
            }else{ // Or else
                Button("Continue", action: askQuestion)
            }
        } message: { // Alert message
            Text("Your score is \(userScore)")
        }
    }
    
    // MARK: Logic
    
    // Will restart all properties for a new game
    func restartGame(){
        roundSequence = 0
        userScore = 0
        askQuestion()
    }
    
    // If the user tapped any flag
    func flagTapped(_ number: Int) {
        roundSequence += 1 // increase round by 1
        withAnimation() { // rotate the flag with animation
            self.rotationDegree = 360
        }
        
        // set alert title and update user score
        if number == correctAnswer {
            scoreTitle = "Correct!"
            userScore += 1
        } else {
            scoreTitle = "Wrong! \nThat's the flag of: \(countries[number])"
            userScore -= 1
        }
        
        // if the game ended change the alert title again
        if roundSequence == roundNumber{
            scoreTitle = "Game Over!"
        }
        
        // trigger the alert
        showingScore = true
    }
    
    // reset the question and flag rotation properties, after the answer
    func askQuestion() {
        selectedFlag = -1
        rotationDegree = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct FlagImage: View{
    var image: Image
    @Binding var selectedFlag: Int
    var number: Int
    @Binding var rotationDegree: CGFloat
    
    var body: some View{
       image
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .opacity(selectedFlag == number || rotationDegree == 0 ? 1: 0.75)
            .scaleEffect(selectedFlag == number || rotationDegree == 0 ? 1.0 : 0.9) // for a good look after tapped
            .rotation3DEffect(.degrees(rotationDegree), axis: (x: 0, y: selectedFlag == number ? rotationDegree: 0, z: 0)) // for rotating the selected flag
    }
}
