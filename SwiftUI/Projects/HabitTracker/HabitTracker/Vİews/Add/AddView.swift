//
//  AddView.swift
//  HabitTracker
//
//  Created by Mehmet Ateş on 11.05.2022.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var pageViewModel : StateViewModel
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var habitType: String = "Persona"
    @State private var createDate: Date = Date.now
    @State private var dailyTimeTarget: Int = 1
    @State private var frequency: Int = 1
    
    let habitTypes: Array<String> = ["Personal", "Fun", "Health", "Lesson"]
    
    var body: some View {
        NavigationView{
            Form{
                Section("Habit Information"){
                    TextField("Habit name", text: $name)
                    TextField("Habit description", text: $description)
                    Picker("Habit type", selection: $habitType) {
                        ForEach(habitTypes, id: \.self) { habit in
                            Button(habit){
                                self.habitType = habit
                            }
                        }
                    }.pickerStyle(.menu)
                }
                
                Section("Habit Properties"){
                    DatePicker("Start date", selection: $createDate, displayedComponents: .date)
                    VStack(alignment: .leading){
                        Text("Daily target")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Picker("Daily Target", selection: $dailyTimeTarget) {
                            ForEach(1..<6, id: \.self) { time in
                                Button("\(time) hour"){
                                    self.dailyTimeTarget = time + 1
                                }
                            }
                        }.pickerStyle(.menu)
                    }
                    VStack(alignment: .leading){
                        Text("Day Frequency")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Picker("Daily Target", selection: $frequency) {
                            ForEach(1..<8, id: \.self) { freq in
                                Button("per \(freq) day on"){
                                    self.frequency = freq + 1
                                }
                            }
                        }.pickerStyle(.menu)
                    }
                }
                
                Button("Save"){
                    pageViewModel.habits.append(HabitModel(name: name, description: description, type: habitType, createDate: createDate, dailyTimeTarget: dailyTimeTarget, lastModify: Date.now))
                    dismiss()
                }
            }.navigationTitle("Add Habit")
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(pageViewModel: StateViewModel())
    }
}
