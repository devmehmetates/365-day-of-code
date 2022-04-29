//
//  AnimationView.swift
//  MultiplicationTable
//
//  Created by Mehmet Ateş on 29.04.2022.
//

import SwiftUI
import Lottie

struct LottieAnimationView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode = .playOnce
    
    var animationView = AnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieAnimationView>) -> UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieAnimationView>) {}
}
