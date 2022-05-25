//
//  HomeView.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 24.05.2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var offlineViewModel: OfflineViewModel = OfflineViewModel()
    @ObservedObject private var pageViewModel: HomeViewModel = HomeViewModel()
    @State private var typeSelection: Int = 0
    
    var body: some View {
        NavigationView{
            if pageViewModel.users.isEmpty{
                ProgressView()
                    .navigationTitle("FriendsFace")
            }else{
                if typeSelection == 0{
                    UserLists(typeSelection: $typeSelection, pageViewModel: pageViewModel, offlineViewModel: offlineViewModel)
                }else{
                    UserLists(typeSelection: $typeSelection, pageViewModel: pageViewModel, offlineViewModel: offlineViewModel)
                }
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct UserLists: View{
    @FetchRequest<CachedUser>(sortDescriptors: [], predicate: nil) var cachedUsers: FetchedResults<CachedUser>
    @Environment(\.managedObjectContext) var moc
    @Binding var typeSelection: Int
    var pageViewModel: HomeViewModel
    var offlineViewModel: OfflineViewModel
    var body: some View{
        List{
            ForEach(typeSelection == 0 ? pageViewModel.users : offlineViewModel.handleCachedToOriginalUser(contents: cachedUsers), id: \.id){ user in
                NavigationLink {
                    DetailView(parentViewModel: pageViewModel, user: user)
                } label: {
                    VStack(alignment: .leading){
                        Text(user.name)
                            .font(.headline)
                        Text(user.isActive ? "Active": "Non-Active")
                            .font(.caption)
                            .foregroundColor(user.isActive ? .green: .red)
                    }
                }
            }
        }.navigationTitle("Friend Face")
            .onAppear{
                offlineViewModel.saveForOffline(moc, contents: pageViewModel.users)
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Picker(selection: $typeSelection) {
                        Text("Online")
                            .tag(0)
                        Text("Offline")
                            .tag(1)
                    } label: {
                        
                    }.pickerStyle(.segmented)
                    
                }
            }
    }
}
