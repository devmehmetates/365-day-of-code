//
//  ManuallyPublish.swift
//  HotProspects
//
//  Created by Mehmet Ateş on 13.06.2022.
//

import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet { // same to @Published
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ManuallyPublish: View {
    @StateObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct ManuallyPublish_Previews: PreviewProvider {
    static var previews: some View {
        ManuallyPublish()
    }
}
