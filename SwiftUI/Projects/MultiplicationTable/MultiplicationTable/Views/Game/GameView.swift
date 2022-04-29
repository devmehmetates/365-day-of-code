//
//  GameView.swift
//  MultiplicationTable
//
//  Created by Mehmet Ateş on 29.04.2022.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var pageViewModel: GameViewModel = GameViewModel()
    var numberOfMultiplication: Int
    var totalQuestion: Int
    
    init(numberOfMultiplication: Int, totalQuestion: Int){
        self.numberOfMultiplication = numberOfMultiplication // 1 eksik gelir
        self.totalQuestion = totalQuestion // 10 az gelir
        self.pageViewModel.askQuestion(constantNumber: numberOfMultiplication)
        self.pageViewModel.updateMaxQuestion(maxQuestion: totalQuestion + 10)
    }
    
    var body: some View {
        if self.pageViewModel.alertToggle{
            LottieAnimationView(name: pageViewModel.alertAnimation, loopMode: .playOnce)
                .frame(width: 90.0.responsizeWidth(), height: 30.0.responsizeHeight(), alignment: .center)
            Text(pageViewModel.alertTitle)
                .font(.largeTitle)
            Text(pageViewModel.alertMessage)
            Button {
                if pageViewModel.isDone{
                    self.presentationMode.wrappedValue.dismiss()
                }else{
                    pageViewModel.alertToggle.toggle()
                    pageViewModel.askQuestion(constantNumber: numberOfMultiplication)
                }
            } label: {
                Text(pageViewModel.alertButtonText)
                    .frame(width: 80.0.responsizeWidth(), height: 5.0.responsizeHeight(), alignment: .center)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }.padding(.top, 7.0.responsizeHeight())
        }else{
            VStack{
                Spacer()
                LottieAnimationView(name: "question")
                    .frame(height: 40.0.responsizeHeight(), alignment: .center)
                
                Text(pageViewModel.answer.question)
                    .font(.largeTitle)
                Text("Cevap nedir?")
                Spacer()
                HStack{
                    ForEach(pageViewModel.choices, id: \.self) { choice in
                        Button {
                            pageViewModel.answerChoice(userAnswer: Int(choice) ?? 0)
                        } label: {
                            Text(choice)
                                .frame(width: 15.0.responsizeWidth(), alignment: .center)
                                .padding(.vertical, 5)
                                .background(.black)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                        }
                    }
                }.padding(.top)
                Spacer()
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    RemainingTimeView(pageViewModel: pageViewModel)
                }
            }.navigationTitle(String(pageViewModel.currentQuestion + 1) + ".Soru")
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(numberOfMultiplication: 5, totalQuestion: 2)
    }
}

struct RemainingTimeView: View{
    @State private var remainingTime: CGFloat = 30
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var pageViewModel: GameViewModel
    
    var body: some View{
        ZStack{
            Text(String(Int(remainingTime)))
        }.onReceive(timer) { _ in
            if remainingTime > 0 && !self.pageViewModel.alertToggle{
                remainingTime -= 1
            } else if remainingTime == 0 || self.pageViewModel.alertToggle{
                self.pageViewModel.answerChoice(userAnswer: 00)
            }
        }
    }
}
