//
//  TransparentLayoutContainers.swift
//  SnowSeeker
//
//  Created by Mehmet Ateş on 29.06.2022.
//

import SwiftUI

struct TransparentLayoutContainers: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        VStack{
            Text(sizeClass.debugDescription)
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
    }
}

struct TransparentLayoutContainers_Previews: PreviewProvider {
    static var previews: some View {
        TransparentLayoutContainers()
            .previewInterfaceOrientation(.portrait)
    }
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}
