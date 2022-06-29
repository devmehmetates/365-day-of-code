//
//  PresententViewWithOptionals.swift
//  SnowSeeker
//
//  Created by Mehmet Ateş on 29.06.2022.
//

import SwiftUI

struct User: Identifiable {
    var id = "Tate McRae"
}

struct PresententViewWithOptionals: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false

    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                selectedUser = User()
                isShowingUser = true
            }
            .sheet(isPresented: $isShowingUser) {
                Text(selectedUser?.id ?? "Unknown")
            }
    }
}


struct PresententViewWithOptionals_Previews: PreviewProvider {
    static var previews: some View {
        PresententViewWithOptionals()
    }
}
