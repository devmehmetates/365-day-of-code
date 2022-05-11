//
//  StateViewModel.swift
//  HabitTracker
//
//  Created by Mehmet Ateş on 11.05.2022.
//

import Foundation
import SwiftUI

class StateViewModel: ObservableObject{
    private let defaults = UserDefaults.standard
    
    @Published var habits: Array<HabitModel> = []{
        didSet{
            if let encoded = try?  JSONEncoder().encode(habits){
                defaults.set(encoded, forKey: "habits")
            }
            setHabitValues()
        }
    }
    
    @Published var habitValues: Array<CGFloat> = []
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "habits"){
            if let decodedItems = try? JSONDecoder().decode([HabitModel].self, from: savedItems){
                habits = decodedItems
                setHabitValues()
                return
            }
        }
        
        habits = []
    }
    
    func updateHabit(_ habit: HabitModel){
        let firstIndex = self.habits.firstIndex { models in
            habit.id == models.id
        }
        
        guard let firstIndex = firstIndex else { return }
        
        self.habits[firstIndex] = habit
    }
    
    func setHabitValues(){
        habitValues.removeAll()
        var completedHabits = 0
        
        for habit in habits{
            if habit.todayState{
                completedHabits += 1
            }
        }
        
        if !habits.isEmpty{
            habitValues.append(CGFloat(completedHabits))
        }
    }
    
    func deleteHabit(_ habitIndex: IndexSet){
        self.habits.remove(atOffsets: habitIndex)
    }
}
