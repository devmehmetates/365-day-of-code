//
//  DashboardView.swift
//  HabitTracker
//
//  Created by Mehmet Ateş on 11.05.2022.
//

import SwiftUI
import SwiftUIAnimatedRingCharts

struct DashboardView: View {
    @StateObject private var pageViewModel = StateViewModel()
    @State private var addSheet: Bool = false
    @State private var reDrawGraph: Bool = false
    
    
    var body: some View {
        NavigationView{
            List{
                HStack{
                    if pageViewModel.habitValues.isEmpty{
                        VStack{
                            Text("Unfortunately you haven't placed any values ​​yet.")
                                .padding(.bottom)
                            Image(systemName: "square.3.layers.3d.down.right.slash")
                                .foregroundColor(.accentColor)
                                .font(.title2)
                        }.font(.caption)
                    }else{
                        if !reDrawGraph{
                            ZStack{
                                RingChartsView(values: pageViewModel.habitValues, colors: [], ringsMaxValue: CGFloat(pageViewModel.habits.count))
                                    .frame(width: 30.0.responsiveW, height: 30.0.responsiveW, alignment: .center)
                                VStack{
                                    HStack(spacing: 0){
                                        Text("\(Int(pageViewModel.habitValues[0]))")
                                            .foregroundColor(.accentColor)
                                        Text("/")
                                        Text("\(pageViewModel.habits.count)")
                                        
                                    }
                                    Text("Habit Completed")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                            }.onChange(of: pageViewModel.habitValues) { _ in
                                reDrawGraph = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    reDrawGraph = false
                                }
                            }
                        }
                    }
                }.frame(width: 92.0.responsiveW, height: 40.0.responsiveW, alignment: .center)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.none)
                ForEach(pageViewModel.habits) { habit in
//                ForEach(habits) { habit in
                    NavigationLink {
                        DetailView(pageViewModel: pageViewModel, habit: habit)
                    } label: {
                        if habit.todayState{
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        }else{
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.accentColor)
                        }
                        VStack(alignment:.leading){
                            Text(habit.name)
                            Text(habit.type)
                                .font(.caption2)
                                .foregroundColor(.accentColor)
                        }
                    }
                }.onDelete { indexSet in
                    pageViewModel.deleteHabit(indexSet)
                }
            }.navigationTitle("Dashboard")
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem {
                        Button {
                            addSheet.toggle()
                        } label: {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $addSheet) {
                    AddView(pageViewModel: pageViewModel)
                }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
