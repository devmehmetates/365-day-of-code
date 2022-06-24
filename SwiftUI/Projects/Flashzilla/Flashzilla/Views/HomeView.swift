//
//  HomeView.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 24.06.2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack{
            // MARK: Background
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            // MARK: Timer and Cards
            VStack{
                // MARK: Timer
                Text("Time: \(viewModel.timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                // MARK: Cards
                ZStack {
                    ForEach(viewModel.cards, id: \.self) { card in
                        let index = viewModel.cards.firstIndex { $0.id == card.id } ?? 0
                        VStack{
                            CardView(card: card){ answer in
                                withAnimation {
                                    viewModel.removeCard(at: index, answer: answer)
                                }
                            }.stacked(at: index, in: viewModel.cards.count)
                                .accessibilityHidden(index < viewModel.cards.count - 1)
                        }
                    }
                }.allowsHitTesting(viewModel.timeRemaining > 0)
                    
                
                // MARK: Restart Button
                if viewModel.cards.isEmpty {
                    Button("Start Again"){
                        viewModel.resetCards()
                    }.padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        
                }
            }
                
            // MARK: Edit Button
            VStack {
                HStack {
                    Spacer()

                    Button {
                        viewModel.showingEditScreen = true
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
            
            // MARK: Accessibility View
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                viewModel.removeCard(at: viewModel.cards.count - 1, answer: false)
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
                                viewModel.removeCard(at: viewModel.cards.count - 1, answer: true)
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
        }
        
        // MARK: Timer process
        .onReceive(viewModel.timer) { time in
            guard viewModel.isActive else { return }

            if viewModel.timeRemaining > 0 {
                viewModel.timeRemaining -= 1
            }else{
                viewModel.isActive = false
                viewModel.cards.removeAll()
            }
        }
        // MARK: Phase process
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if viewModel.cards.isEmpty == false {
                    viewModel.isActive = true
                }
            } else {
                viewModel.isActive = false
            }
        }
        // MARK: Edit View Sheet
        .sheet(isPresented: $viewModel.showingEditScreen, onDismiss: viewModel.resetCards, content: EditCards.init).onAppear(perform: viewModel.resetCards)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
