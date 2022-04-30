//
//  FirstView.swift
//  iExpense
//
//  Created by Mehmet Ateş on 30.04.2022.
//

import SwiftUI

struct FirstView: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "devmehmetates")
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
