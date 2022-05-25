//
//  UserModel.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 24.05.2022.
//

import Foundation

struct UserModel: Codable{
    let id: String
    let name: String
    let age: Int
    let about: String
    let isActive: Bool
    let company: String
    let email: String
    let address: String
    let registered: String
    let tags: Array<String>
    let friends: Array<Friend>
}




