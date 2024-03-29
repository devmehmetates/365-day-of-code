//
//  MainView.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 21.06.2022.
//

import SwiftUI

struct MainView: View {
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @State private(set) var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var showingEditScreen = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(Array(zip(cards.indices, cards)), id: \.1.id) { index, card in
                        VStack{
                            CardView(card: card){ answer in
                                withAnimation {
                                    removeCard(at: index, answer: answer)
                                }
                            }.stacked(at: index, in: cards.count)
                                .accessibilityHidden(index < cards.count - 1)
                        }
                    }
                    
//                    ForEach(0..<cards.count, id: \.self) { index in
//                        CardView(card: cards[index]) { answer in
//                           withAnimation {
//                               removeCard(at: index, answer: answer)
//                           }
//                        }
//                        .stacked(at: index, in: cards.count)
//                        .allowsHitTesting(index == cards.count - 1)
//                        .accessibilityHidden(index < cards.count - 1)
//                    }
                }.allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, answer: false)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")

                        Spacer()

                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, answer: true)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }.onReceive(timer) { time in
            guard isActive else { return }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }.sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init).onAppear(perform: resetCards)
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func removeCard(at index: Int, answer: Bool) {
        guard index >= 0 else { return }
        checkCardAnswer(index: index, answer: answer)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func checkCardAnswer(index: Int, answer: Bool){
        let card = cards[index]
        if (card.answer == card.questionAnswer) == answer{
            cards.remove(at: index)
        }else{
            cards.insert(card, at: cards.count)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

