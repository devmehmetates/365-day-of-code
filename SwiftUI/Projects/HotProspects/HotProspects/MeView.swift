//
//  MeView.swift
//  HotProspects
//
//  Created by Mehmet Ateş on 15.06.2022.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {

            Form {
                Section{
                    TextField("Name", text: $name)
                        .textContentType(.name)

                    TextField("Email address", text: $emailAddress)
                        .textContentType(.emailAddress)
                } header: {
                    Text("Your information")
                } footer: {
                    Text("You can change that values")
                }
                
                
                Section("Your QR Code"){
                    HStack{
                        Spacer()
                        Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Your code")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
