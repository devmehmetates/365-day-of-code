//
//  HomeViewModel.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 24.05.2022.
//

import Foundation

class HomeViewModel: ObservableObject{
    @Published var users = Array<UserModel>()
    let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
    
    init(){
        Task{
            if users.isEmpty{
                await getDatas()
            }
        }
    }
    
    func getDatas() async {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }else if let data = data{
                let decodedData = try? JSONDecoder().decode([UserModel].self, from: data)
                if let nODecodedData = decodedData{
                    DispatchQueue.main.async {
                        self.users = nODecodedData
                    }
                }else{
                    print("Decode Error")
                }
            }
        }.resume()
    }
    
    func getFriendsToUser(id: String) -> UserModel{
        let firstIndex = users.firstIndex { model in
            model.id == id
        }
        
        if let firstIndex = firstIndex {
            return users[firstIndex]
        }else{
            return UserModel(id: "", name: "", age: 0, about: "", isActive: false, company: "", email: "", address: "", registered: "", tags: [], friends: [])
        }
    }
    
    func decodeStringToFormattedString(_ dateString: String) -> String{
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: dateString)
        return date?.formatted() ?? "Unknowed"
    }
}
