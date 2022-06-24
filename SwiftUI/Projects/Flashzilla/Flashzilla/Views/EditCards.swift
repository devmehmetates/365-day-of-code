//
//  EditCards.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 23.06.2022.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newQuestionAnswer = ""
    @State private var newAnswer = ""

    var body: some View {
        NavigationView {
            List {
                Section{
                    TextField("Prompt", text: $newPrompt)
                    TextField("Question Answer", text: $newQuestionAnswer)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                } header: {
                    Text("Add new card")
                } footer: {
                    Text("If answer is empty, question answer will be correct answer.")
                        .font(.caption)
                }

                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].questionAnswer)
                                .foregroundColor(.secondary)
                            Text(cards[index].answer)
                                .foregroundColor(.green)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }

    func done() {
        dismiss()
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }

    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }

    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedQuestionAnswer = newQuestionAnswer.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.isEmpty ? nil : newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedQuestionAnswer.isEmpty == false else { return }

        let card = Card(prompt: trimmedPrompt, questionAnswer: trimmedQuestionAnswer, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
        newPrompt = ""
        newAnswer = ""
        newQuestionAnswer = ""
    }

    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}
