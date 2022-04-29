//
//  LearnPreferenceView.swift
//  MultiplicationTable
//
//  Created by Mehmet Ateş on 29.04.2022.
//

import SwiftUI

struct LearnPreferenceView: View {
    @State private var numberSelection: Int = 0
    @State private var questionSelection: Int = 10
    
    var body: some View {
        NavigationView{
            VStack{
                LottieAnimationView(name: "select", loopMode: .loop)
                    .frame(width: 100.0.responsizeWidth(), height: 40.0.responsizeHeight(), alignment: .center)
                
                VStack(alignment:.leading){
                    VStack(alignment:.leading, spacing: 5){
                        Text("Hadi bir sayı seç!")
                            .font(.title3)
                        Divider()
                            .frame(width: 90.0.responsizeWidth(), alignment: .leading)
                    }
                    Picker(selection: $numberSelection) {
                        ForEach(1..<10) { number in
                            Button("x\(number) ile başlayalım!"){
                                numberSelection = number
                            }
                        }
                    } label: {
                        Text("Hadi Seçellim")
                    }.accentColor(.primary)
                }
                
                VStack(alignment:.leading){
                    VStack(alignment:.leading, spacing: 5){
                        Text("Kaç soru ile mücadele edelim?")
                            .font(.title3)
                        Divider()
                            .frame(width: 90.0.responsizeWidth(), alignment: .leading)
                        HStack(spacing: 2){
                            Image(systemName: "info.circle")
                            Text("Cesur çocuklar 20 soru ile mücadele edebilir.")
                        }.font(.caption)
                    }
                    Picker(selection: $questionSelection) {
                        ForEach(10..<30) { number in
                            Button("\(number) soru istiyorum!"){
                                questionSelection = number
                            }
                        }
                    } label: {
                        Text("Hadi Seçellim")
                    }.accentColor(.primary)
                }
                Spacer()
                NavigationLink {
                    GameView(numberOfMultiplication: numberSelection, totalQuestion: questionSelection)
                } label: {
                    Text("Hadi Başlayalım!")
                        .frame(width: 80.0.responsizeWidth(), height: 5.0.responsizeHeight(), alignment: .center)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                }.padding(.bottom)
            }.navigationBarHidden(true)
        }
    }
}

struct LearnPreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        LearnPreferenceView()
    }
}
