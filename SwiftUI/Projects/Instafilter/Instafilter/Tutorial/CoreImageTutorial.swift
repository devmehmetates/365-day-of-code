//
//  CoreImageTutorial.swift
//  Instafilter
//
//  Created by Mehmet Ateş on 27.05.2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins


struct CoreImageTutorial: View {
    @State private var image: Image?
    
    var body: some View {
        NavigationView{
            VStack {
                image?
                    .resizable()
                    .scaledToFill()
            }
            .onAppear(perform: loadImage)
            .navigationTitle("Guess the Picture")
        }
       
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
        let currentFilter = CIFilter.pixellate()
        currentFilter.inputImage = beginImage
        currentFilter.scale = 30
        
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 200
        
//        let currentFilter = CIFilter.twirlDistortion()
//        currentFilter.inputImage = beginImage
//        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
//
//        let amount = 1.0
//
//        let inputKeys = currentFilter.inputKeys
//
//        if inputKeys.contains(kCIInputIntensityKey) {
//            currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
//        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 100, forKey: kCIInputRadiusKey) }
//        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            
            image = Image(uiImage: uiImage)
        }
    }
}

struct CoreImageTutorial_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageTutorial()
    }
}
