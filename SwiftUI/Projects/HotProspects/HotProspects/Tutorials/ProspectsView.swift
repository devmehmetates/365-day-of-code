//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Mehmet Ateş on 15.06.2022.
//

import SwiftUI

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }.navigationTitle(title)
                .toolbar {
                    Button {
                        let prospect = Prospect()
                        prospect.name = "Paul Hudson"
                        prospect.emailAddress = "paul@hackingwithswift.com"
                        prospects.people.append(prospect)
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}

enum FilterType {
    case none, contacted, uncontacted
}
