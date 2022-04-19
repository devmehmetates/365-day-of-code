//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mehmet Ateş on 19.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var gameOver: Bool = false
    @State private var alertTriggered: Bool = false
    @State private var alertTitle: String = ""
    @State private var score: Int = 0
    @State private var userSelected: Bool = false
    @State private var tour: Float = 1
    @State private var computerChoice: Int = Int.random(in: 0...2)
    @State private var userChoice: Int = 0
    @State private var remainingTime: Float = 10
    private let contents = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
         NavigationView {
            VStack{
                VStack{
                    ProgressView(value: tour, total: 10)
                        .progressViewStyle(.linear)
                        .tint(.teal)
                        .frame(width: 90.0.getResponsive(type: .width))
                }
                Spacer()
                GameCard(alertTriggered: $alertTriggered, alertTitle: $alertTitle, selected: $computerChoice, userSelected: $userSelected, computer: $computerChoice, user: $userChoice, score: $score, tour: $tour, remainingTime: $remainingTime, cardType: .pc, contents: contents) {
                    self.setTourResult()
                } alertAction: {
                    self.nextOrRestartTour()
                }
                GameCard(alertTriggered: $alertTriggered, alertTitle: $alertTitle, selected: $userChoice, userSelected: $userSelected, computer: $computerChoice, user: $userChoice, score: $score, tour: $tour, remainingTime: $remainingTime, cardType: .user, contents: contents) {
                    self.setTourResult()
                } alertAction: {
                    self.nextOrRestartTour()
                }
                Spacer()
                ChoiceArea(userSelected: self.$userSelected, select: self.$userChoice, remainingTime: self.$remainingTime, contents: self.contents, triggerAction: self.setTourResult)
                Spacer()
            }.alert("Game Over!", isPresented: self.$gameOver, actions: {
                Button(role: .cancel) {
                    self.nextOrRestartTour()
                } label: {
                    Text("Restart Game!")
                }
            }, message: {
                Text(alertTitle)
            })
            .navigationTitle("Tour: \(Int(tour))")
                 .toolbar {
                     ToolbarItem(placement: .navigationBarTrailing) {
                         Text("Score: \(score)")
                     }
                 }
         }
    }
    
    func setTourResult(){
        switch userChoice{
        case 0:
            if computerChoice == 0{
                self.alertTitle = "Draw!"
            }else if computerChoice == 1 {
                self.alertTitle = "Lose!"
                score -= 1
            }else{
                self.alertTitle = "Win!"
                score += 1
            }
            
        case 1:
            if computerChoice == 1{
                self.alertTitle = "Draw!"
            }else if computerChoice == 2 {
                self.alertTitle = "Lose!"
                score -= 1
            }else{
                self.alertTitle = "Win!"
                score += 1
            }
            
        case 2:
            if computerChoice == 2{
                self.alertTitle = "Draw!"
            }else if computerChoice == 2 {
                self.alertTitle = "Lose!"
                score -= 1
            }else{
                self.alertTitle = "Win!"
                score += 1
            }
            
        default:
            score += 0
        }
        if tour < 10{
            self.alertTriggered = true
        }else{
            alertTitle = "Your score is: \(score)"
            self.gameOver = true
        }
       
    }
    
    func nextOrRestartTour(){
        if tour < 10{
            tour += 1
            self.computerChoice = Int.random(in: 0...2)
            userSelected.toggle()
            remainingTime = 10
        }else{
            tour = 1
            userSelected.toggle()
            remainingTime = 10
            score = 0
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct GameCard: View{
    @Binding var alertTriggered: Bool
    @Binding var alertTitle: String
    @Binding var selected: Int
    @Binding var userSelected: Bool
    @Binding var computer: Int
    @Binding var user: Int
    @Binding var score: Int
    @Binding var tour: Float
    @Binding var remainingTime: Float
    var cardType: CardType
    var contents: Array<String>
    var triggerAction: () -> Void
    var alertAction: () -> Void
   
    
    var body: some View{
        ZStack(alignment: .center){
            HStack{
                Image(systemName: cardType == .pc ? "iphone" : "person")
                    .padding()
                Spacer()
            }.frame(width: 90.0.getResponsive(type: .width), height: 30.0.getResponsive(type: .width))
            
            if !userSelected && cardType == .pc{
                Text("I'm ready. Make A Choice!")
            }else if !userSelected && cardType == .user{
                ZStack {
                    HStack{
                        Spacer()
                        Button {
                            userSelected.toggle()
                            triggerAction()
                        } label: {
                            Image(systemName: "checkmark.circle")
                        }
                    }.padding()
                    VStack{
                        Image(contents[selected])
                        Text(contents[selected])
                    }
                }
            }else{
                VStack{
                    Image(contents[selected])
                    Text(contents[selected])
                }
            }
        }.frame(width: 90.0.getResponsive(type: .width), height: 30.0.getResponsive(type: .width), alignment: .center)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke())
            .alert(alertTitle, isPresented: self.$alertTriggered) {
                Button(role: .cancel) {
                    alertAction()
                } label: {
                    Text("Go Next!")
                }
            }
    }
}

struct ChoiceArea: View{
    @Binding var userSelected: Bool
    @Binding var select: Int
    @Binding var remainingTime: Float
    var contents: Array<String>
    var triggerAction: () -> Void
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View{
        VStack {
            HStack{
                ForEach(0..<3, id: \.self) { choiceIndex in
                    Button {
                        select = choiceIndex
                    } label: {
                        VStack{
                            Image(contents[choiceIndex])
                            Text(contents[choiceIndex])
                        }
                    }.frame(width: 20.0.getResponsive(type: .width))
                        .disabled(userSelected)
                }
            }.padding(.bottom)
            VStack{
                Text("Remaining Time: \(Int(remainingTime)) ")
                ProgressView(value: remainingTime, total: 10)
                    .progressViewStyle(.linear)
                    .tint(remainingTime > 7 ? .green : remainingTime > 4 ? .yellow : .red)
                    .frame(width: 90.0.getResponsive(type: .width))
            }
        }.onReceive(timer) { _ in
            if remainingTime > 0 && !userSelected {
                withAnimation(.easeInOut(duration: 1)) {
                    remainingTime -= 1
                }
            } else if remainingTime == 0 && !userSelected{
                userSelected.toggle()
                triggerAction()
            }
        }
        .frame(width: 90.0.getResponsive(type: .width))
            
    }
}

extension Double{
    func getResponsive(type: ResponsiveSize) -> Double{
        if type == ResponsiveSize.height{
            return self * (UIScreen.main.bounds.height / 100)
        }else{
            return self * (UIScreen.main.bounds.width / 100)
        }
    }
}


enum ResponsiveSize{
    case height
    case width
}

enum CardType{
    case user
    case pc
}


