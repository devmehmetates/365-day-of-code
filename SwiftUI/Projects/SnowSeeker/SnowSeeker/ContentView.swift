//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Mehmet Ateş on 30.06.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortType: SortType = .alfabet
    @State var resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibilityLabel("This is a favorite resort")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Picker("", selection: self.$sortType) {
                    ForEach(SortType.allCases, id:\.self){ value in
                        Text(value.rawValue)
                            .tag(value)
                    }
                }
            }
            
            WelcomeView()
        }.environmentObject(favorites)
            .onChange(of: self.sortType) { newSortValue in
                sortByType(type: newSortValue)
            }.onAppear {
                sortByType(type: .alfabet)
            }
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func sortByType(type: SortType){
        switch type {
        case .alfabet:
            self.resorts.sort { $0.name < $1.name }
        case .country:
            self.resorts.sort { $0.country < $1.country }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

enum SortType: String, CaseIterable{
    case alfabet = "By Alfabet"
    case country = "By Country"
}
