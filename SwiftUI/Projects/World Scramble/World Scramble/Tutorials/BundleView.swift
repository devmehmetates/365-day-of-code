//
//  BundleView.swift
//  World Scramble
//
//  Created by Mehmet Ateş on 23.04.2022.
//

import SwiftUI

struct BundleView: View {
    var body: some View {
        Button("Load File", action: loadBundle)
    }
    
    func loadBundle(){
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                print(fileContents)
            }
        }
    }
}

struct Bundle_Previews: PreviewProvider {
    static var previews: some View {
        BundleView()
    }
}
