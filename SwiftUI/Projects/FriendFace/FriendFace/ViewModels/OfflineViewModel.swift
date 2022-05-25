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
            do{
                try moc.save()
            }catch{
                fatalError("save error")
            }
            
        }
    }
    
    func handleCachedToOriginalUser(contents: FetchedResults<CachedUser>) -> Array<UserModel>{
        var resultList: Array<UserModel> = []
        for cachedUser in contents{
            let user: UserModel = UserModel(id: cachedUser.wrappedId, name: cachedUser.wrappedName, age: Int(cachedUser.age), about: cachedUser.wrappedAbout, isActive: cachedUser.isActive, company: cachedUser.wrappedCompany, email: cachedUser.wrappedEmail, address: cachedUser.wrappedAddress, registered: cachedUser.wrappedRegistered, tags: revertHandleTags(tags: cachedUser.wrappedTags), friends: [])
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
    
    func handleCachedFriends(friends: Array<Friend>, moc: NSManagedObjectContext) -> [CachedFriend]{
        var resultList: Array<CachedFriend> = []
        for friend in friends {
            let cachedFriend = CachedFriend(context: moc)
            cachedFriend.id = friend.id
            cachedFriend.name = friend.name
            resultList.append(cachedFriend)
        }
        
        return resultList
    }
    
    func revertHandleCachedFriends(cachedFriends: Array<NSManagedObject>) -> [Friend]{
        var resultList: Array<Friend> = []
        for cachedFriend in cachedFriends {
            let handledCachedFriend = cachedFriend as! CachedFriend
            let friend = Friend(id: handledCachedFriend.wrappedId, name: handledCachedFriend.wrappedName)
            resultList.append(friend)
        }
        
        return resultList
    }
}
