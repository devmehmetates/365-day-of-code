//
//  UsingShareSheet.swift
//  NewFeaturesOnSwiftUI
//
//  Created by Mehmet Ateş on 8.06.2022.
//

import SwiftUI

struct UsingShareSheet: View {
    var anyImage = Image("tate")
    var imageFile = ImageFile(image: Image("tate"))
    
    var body: some View {
        VStack{
            Form{
                ShareLink(item: "SwiftUI is Awesome!"){
                    Text("Share string button")
                }
                ShareLink(item: URL(string: "https://developer.apple.com/wwdc22/")!){
                    Text("Share URL button")
                }
                ShareLink(item: anyImage, preview: SharePreview("Tate McRae", image: anyImage)){ // This is not worked
                    Text("Share Image button (not working for save to library maybe thats fact by beta)")
                }
                ShareLink(item: imageFile, preview: SharePreview("Tate McRae", image: anyImage)){ // This is not worked
                    Text("Share Image button (not working with transferable for save to library)")
                }
            }
        }
    }
}

struct UsingShareSheet_Previews: PreviewProvider {
    static var previews: some View {
        UsingShareSheet()
    }
}

struct ImageFile: Transferable{
    var image: Image
    static var transferRepresentation: some TransferRepresentation{
        ProxyRepresentation(exporting: \.image)
    }
}
