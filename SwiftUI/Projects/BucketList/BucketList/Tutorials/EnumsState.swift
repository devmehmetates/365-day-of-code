//
//  EnumsState.swift
//  BucketList
//
//  Created by Mehmet Ateş on 1.06.2022.
//

import SwiftUI

struct EnumsState: View {
    @State var loadingState = LoadingState.loading
    
    var body: some View {
        NavigationView{
            Group{
                if loadingState == .loading {
                    LoadingView()
                } else if loadingState == .loaded {
                    SuccessView()
                } else if loadingState == .failed {
                    FailedView()
                }
            }.navigationTitle("Enum State")
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if Int.random(in: 0...1) == 0{
                    self.loadingState = .loaded
                }else{
                    self.loadingState = .failed
                }
            }
        }
    }
}

enum LoadingState {
    case loading, loaded, failed
}

struct EnumsState_Previews: PreviewProvider {
    static var previews: some View {
        EnumsState()
    }
}

struct LoadingView: View {
    var body: some View {
        HStack{
            Text("Loading...")
            ProgressView()
        }
       
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}
