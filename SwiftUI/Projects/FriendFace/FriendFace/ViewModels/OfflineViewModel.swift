//
//  OfflineViewModel.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 25.05.2022.
//

import Foundation
import CoreData
import SwiftUI

class OfflineViewModel: ObservableObject{
    func saveForOffline(_ moc: NSManagedObjectContext, contents: Array<UserModel>){
        for user in contents{
            let cachedUser = CachedUser(context: moc)
            cachedUser.id = user.id
            cachedUser.name = user.name
            cachedUser.age = Int16(user.age)
            cachedUser.about = user.about
            cachedUser.isActive = user.isActive
            cachedUser.company = user.company
            cachedUser.email = user.email
            cachedUser.address = user.address
            cachedUser.registered = user.registered
            cachedUser.tags = handleTags(tags: user.tags)
            handleCachedFriends(user: cachedUser, friends: user.friends, moc: moc)
            
        }
    }
    
    func handleCachedToOriginalUser(contents: FetchedResults<CachedUser>) -> Array<UserModel>{
        var resultList: Array<UserModel> = []
        for cachedUser in contents{
            let user: UserModel = UserModel(id: cachedUser.wrappedId, name: cachedUser.wrappedName, age: Int(cachedUser.age), about: cachedUser.wrappedAbout, isActive: cachedUser.isActive, company: cachedUser.wrappedCompany, email: cachedUser.wrappedEmail, address: cachedUser.wrappedAddress, registered: cachedUser.wrappedRegistered, tags: revertHandleTags(tags: cachedUser.wrappedTags), friends: revertHandleCachedFriends(cachedFriends: cachedUser.friendArray))
            print(revertHandleCachedFriends(cachedFriends: cachedUser.friendArray))
            resultList.append(user)
        }
        
        return resultList
    }
    
    func handleTags(tags: Array<String>) -> [NSString]{
        var resultList: Array<NSString> = []
        for tag in tags {
            resultList.append(tag as NSString)
        }
        
        return resultList
    }
    
    func revertHandleTags(tags: Array<NSString>) -> [String]{
        var resultList: Array<String> = []
        for tag in tags {
            resultList.append(tag as String)
        }
        
        return resultList
    }
    
    func handleCachedFriends(user: CachedUser, friends: Array<Friend>, moc: NSManagedObjectContext){
        print(user)
        
        for friend in friends {
            let cachedFriend = CachedFriend(context: moc)
            cachedFriend.id = friend.id
            cachedFriend.name = friend.name
            cachedFriend.friend = user
        }
        
        do{
            try moc.save()
        }catch{
            fatalError("save error")
        }
    }
    
    func revertHandleCachedFriends(cachedFriends: Array<CachedFriend>) -> [Friend]{
        var resultList: Array<Friend> = []
        for cachedFriend in cachedFriends {
            let friend = Friend(id: cachedFriend.wrappedId, name: cachedFriend.wrappedName)
            resultList.append(friend)
        }
        return resultList
    }
}
