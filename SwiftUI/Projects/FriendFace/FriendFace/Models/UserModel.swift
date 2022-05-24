//
//  UserModel.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 24.05.2022.
//

import Foundation

struct UserModel: Codable{
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: Array<String>
    let friends: Array<Friend>
}
