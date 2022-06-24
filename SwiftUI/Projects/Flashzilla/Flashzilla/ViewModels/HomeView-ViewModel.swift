//
//  HomeView-ViewModel.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 24.06.2022.
//

import Foundation

class HomeViewModel: ObservableObject{
    // MARK: Timer Properties
    @Published var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // MARK: Scene Phase Property
    @Published var isActive = true
    
    // MARK: Card property
    @Published var cards = [Card]()
    
    // MARK: Edit sheet property
    @Published var showingEditScreen = false
    
    func removeCard(at index: Int, answer: Bool) {
        guard index >= 0 else { return }
        checkCardAnswer(index: index, answer: answer)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() -> Void {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    
    private func checkCardAnswer(index: Int, answer: Bool){
        let card = cards[index]
        if !((card.answer == card.questionAnswer) == answer){
            cards.append(card)
        }else{
            cards.remove(at: index)
        }
        print(cards.count)
    }
    
    
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
}
