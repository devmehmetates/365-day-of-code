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
    @State private var qrCode = UIImage()
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
                        Image(uiImage: qrCode)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .contextMenu {
                                Button {
                                    let imageSaver = ImageSaver()
                                    imageSaver.writeToPhotoAlbum(image: qrCode)
                                } label: {
                                    Label("Save to Photos", systemImage: "square.and.arrow.down")
                                }
                            }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateCode)
            .onChange(of: name) { _ in updateCode() }
            .onChange(of: emailAddress) { _ in updateCode() }
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                qrCode = UIImage(cgImage: cgimg)
                return qrCode
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
