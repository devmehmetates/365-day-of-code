//
//  DetailView.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 24.05.2022.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var parentViewModel: HomeViewModel
    var user: UserModel
    let randomColors: Array<Color> = [.red, .green, .blue, .indigo, .orange, .teal, .pink, .purple]
    
    var body: some View {
        Form{
            Section{
                TextForForm(placeHolderText: "Name: ", contentText: user.name)
                TextForForm(placeHolderText: "Age: ", contentText: user.age.formatted())
                Text(user.about)
            } header: {
                Text("User Information")
            } footer: {
                Text(parentViewModel.decodeStringToFormattedString(user.registered))
            }
            
            Section("Contact Information"){
                TextForForm(placeHolderText: "Company: ", contentText: user.company.capitalized)
                TextForForm(placeHolderText: "Email: ", contentText: user.email)
                Text(user.address)

            }
            
            Section("Friends"){
                if !user.friends.isEmpty{
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(user.friends, id: \.id) { friend in
                                NavigationLink {
                                    DetailView(parentViewModel: parentViewModel, user: parentViewModel.getFriendsToUser(id: friend.id))
                                } label: {
                                    VStack{
                                        Text(friend.name)
                                    }.frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3, alignment: .center)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                                        .padding(5)
                                        .contentShape(Rectangle())
                                }.buttonStyle(.plain)
                            }
                            
                        }
                    }
                }else{
                    Text("For using friends property, you must be in online mood")
                }
            }
            
            Section("Tags"){
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(user.tags, id: \.self) { tag in
                            Text(tag)
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                                .padding(5)
                                .foregroundColor(randomColors[Int.random(in: 0...7)])
                        }
                    }
                    
                }
            }
            
        }.navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text(user.isActive ? "Active": "Non-Active")
                    .font(.caption)
                    .foregroundColor(user.isActive ? .green: .red)
            }
        }
    }
}


struct TextForForm: View{
    var placeHolderText: String
    var contentText: String
    
    var body: some View{
        HStack(alignment:.top){
            Text(placeHolderText)
                .foregroundColor(.secondary)
            Text(contentText)
                .font(.headline)
        }
    }
}
