//
//  UserDefaultsUsage.swift
//  iExpense
//
//  Created by Mehmet Ateş on 30.04.2022.
//

import SwiftUI

struct UserDefaultsUsage: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "defaults")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "defaults")
        }
    }
}

struct UserDefaults_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsUsage()
    }
}


struct AppStorageUsage: View{
    @AppStorage("appStorage") private var tapCount = 0
    var body: some View{
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}


struct PreviewUsages: View{
    var body: some View{
        VStack{
            UserDefaultsUsage()
            AppStorageUsage()
        }
    }
}
