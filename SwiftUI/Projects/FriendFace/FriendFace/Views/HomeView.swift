//
//  HomeView.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 24.05.2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var pageViewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView{
            if pageViewModel.users.isEmpty{
                ProgressView()
                    .navigationTitle("FriendsFace")
            }else{
                List{
                    ForEach(pageViewModel.users, id: \.id){ user in
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
            }
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
