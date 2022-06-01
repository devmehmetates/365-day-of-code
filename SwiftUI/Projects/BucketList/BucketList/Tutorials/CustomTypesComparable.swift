//
//  CustomTypesComparable.swift
//  BucketList
//
//  Created by Mehmet Ateş on 1.06.2022.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct CustomTypesComparable: View {
    
    // MARK: Basic Compare
//    let values = [1, 5, 3, 6, 2, 9].sorted()
//
//    var body: some View {
//        List(values, id: \.self) {
//            Text(String($0))
//        }
//    }
    // MARK: Before using Comparable Protocol
//    let users = [
//        User(firstName: "Arnold", lastName: "Rimmer"),
//        User(firstName: "Kristine", lastName: "Kochanski"),
//        User(firstName: "David", lastName: "Lister"),
//    ].sorted {
//        $0.lastName < $1.lastName
//    }
    
    // MARK: After using Comparable Protocol
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

struct CustomTypesComparable_Previews: PreviewProvider {
    static var previews: some View {
        CustomTypesComparable()
    }
}
