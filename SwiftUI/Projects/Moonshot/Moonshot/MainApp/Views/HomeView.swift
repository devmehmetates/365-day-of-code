//
//  ContentView.swift
//  Moonshot
//
//  Created by Mehmet Ateş on 3.05.2022.
//

import SwiftUI

struct HomeView: View {
    @State private var showingGrid: Bool = false
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            Group{
                if showingGrid{
                    GridViewLayout(missions: missions, astronauts: astronauts)
                }else{
                    List(missions){ mission in
                        CommonMissionView(mission: mission, astronauts: astronauts)
                            .listRowBackground(Color.darkBackground)
                            .listRowSeparator(.hidden)
                            
                    }.listStyle(.plain)
                       
                        
                }
            }.navigationTitle("Moonshot")
                .background(.darkBackground)
                .toolbar {
                    Picker("Type", selection: $showingGrid) {
                        Button("Grid"){
                            showingGrid = true
                        }.tag(true)
                        Button("List"){
                            showingGrid = false
                        }.tag(false)
                    }.pickerStyle(.segmented)
                }
        }.preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct GridViewLayout: View{
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var missions: [Mission]
    var astronauts: [String: Astronaut]
    
    var body: some View{
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    CommonMissionView(mission: mission, astronauts: astronauts)
                }
            }.padding([.horizontal, .bottom])
        }
    }
}

struct CommonMissionView: View{
    var mission: Mission
    var astronauts : [String: Astronaut]
    
    var body: some View{
        NavigationLink {
            MissionView(mission: mission, astronauts: astronauts)
        } label: {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                VStack {
                    Text(mission.displayName)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(mission.formattedLaunchDate)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.5))
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.lightBackground)
            }.clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(.lightBackground))
        }
    }
}
