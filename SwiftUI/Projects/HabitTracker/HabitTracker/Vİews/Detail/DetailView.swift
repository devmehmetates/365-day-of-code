//
//  DetailView.swift
//  HabitTracker
//
//  Created by Mehmet Ateş on 11.05.2022.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var pageViewModel : StateViewModel
    @State var habit: HabitModel
    @State private var dailyTimeSpend: Int = 0
    @State private var overlayToggle: Bool = false
    
    let habitTypes: Array<String> = ["Personal", "Fun", "Health", "Lesson"]
    
    var body: some View {
        ZStack{
            Form{
                Section("Daily Activity"){
                    VStack(alignment: .leading){
                        Text("Daily progress")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        ProgressView(value: CGFloat(dailyTimeSpend), total: CGFloat(habit.dailyTimeTarget))
                    }.onAppear{
                        dailyTimeSpend = habit.dailywastedTime ?? 0
                    }
                    
                    VStack(alignment: .leading){
                        Text("Daily time spend")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Picker("Daily time spend", selection: $dailyTimeSpend) {
                            ForEach(0..<(habit.dailyTimeTarget + 1), id: \.self) { time in
                                Button("I spent \(time) hours this day."){
                                    self.dailyTimeSpend = time + 1
                                }
                            }
                        }.pickerStyle(.menu)
                    }
                }
                
                Section{
                    TextField("Habit name", text: $habit.name)
                    TextField("Habit description", text: $habit.description)
                    Picker("Habit type", selection: $habit.type) {
                        ForEach(habitTypes, id: \.self) { habit in
                            Button(habit){
                                self.habit.type = habit
                            }
                        }
                    }.pickerStyle(.menu)
                } header: {
                    Text("Habit Information")
                } footer: {
                    Text("You can change these values")
                }
                
                Section("Habit Properties"){
                    DatePicker("Start date", selection: $habit.createDate, displayedComponents: .date)
                        .disabled(true)
                    VStack(alignment: .leading){
                        Text("Daily target")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Picker("Daily Target", selection: $habit.dailyTimeTarget) {
                            ForEach(1..<6, id: \.self) { time in
                                Button("\(time) hour"){
                                    self.habit.dailyTimeTarget = time + 1
                                }
                            }
                        }.pickerStyle(.menu)
                    }
                    VStack(alignment: .leading){
                        Text("Day frequency")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Picker("Daily Target", selection: $habit.frequency) {
                            ForEach(1..<8, id: \.self) { freq in
                                Button("per \(freq) day on"){
                                    self.habit.frequency = freq + 1
                                }
                            }
                        }.pickerStyle(.menu)
                    }
                }
                
                
                Button("Save"){
                    withAnimation {
                        overlayToggle.toggle()
                    }
                    habit.dailywastedTime = self.dailyTimeSpend
                    pageViewModel.updateHabit(habit)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        overlayToggle.toggle()
                        dismiss()
                    }
                }
            }.navigationTitle("Habit Detail")
            
            if overlayToggle{
                ZStack{
                    Rectangle()
                        .frame(width: 40.0.responsiveW, height: 50.0.responsiveW, alignment: .center)
                        .background(.ultraThinMaterial)
                        .foregroundColor(.clear)
                        .cornerRadius(15)
                    VStack{
                        Text("Saving...")
                        ProgressView()
                            .tint(.accentColor)
                    }
                }
            }
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(pageViewModel: StateViewModel(), habit: HabitModel(name: "Swift", description: "HackingWithSwift", type: "Lesson", createDate: .now, dailyTimeTarget: 1, lastModify: .now))
    }
}
