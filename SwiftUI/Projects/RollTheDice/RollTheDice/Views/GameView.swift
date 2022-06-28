//
//  GameView.swift
//  RollTheDice
//
//  Created by Mehmet Ateş on 28.06.2022.
//

import SwiftUI

struct GameView: View {
    @State private var diceOne: Int = 1
    @State private var diceTwo: Int = 1
    @State private var diceCount: Int = 4
    @State private var showCount: Int = 0
    @State private var isTimerRunning: Bool = false
    @State private var timerCount: Double = 0

    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView{
            VStack{
                if isTimerRunning{
                    HStack{
                        Text("Rolling...")
                        ProgressView()
                    }
                }else{
                    Text("Total Score: \(diceOne + diceTwo)")
                }
                HStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.red)
                        .overlay(Text(diceOne.formatted()).foregroundColor(.white))
                        
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.red)
                        .overlay(Text(diceTwo.formatted()).foregroundColor(.white))
                }
                Button("Roll"){
                    isTimerRunning.toggle()
                }.padding()
                    .foregroundColor(.white)
                    .background(.red)
                    .clipShape(Capsule())
                    .disabled(isTimerRunning)
                   
            }.navigationTitle("Roll The Dice")
                .toolbar {
                    Picker("Select one", selection: $showCount) {
                        ForEach(4..<100) { num in
                            Button("Dice edges: \(num.formatted())"){
                                diceCount = num
                            }
                        }
                    }
                }
        }.onChange(of: showCount) { newValue in
            diceCount = showCount + 4
        }.onReceive(timer) { time in
            if isTimerRunning {
                withAnimation {
                    self.diceOne = Int.random(in: 1...diceCount)
                    self.diceTwo = Int.random(in: 1...diceCount)
                }
                
                if timerCount.rounded() == 2.0 {
                    isTimerRunning.toggle()
                    timerCount = 0
                } else {
                    print("The time is now \(time)")
                }
                timerCount += 0.2
            }

        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
