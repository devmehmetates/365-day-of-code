//
//  ImageInterpolation.swift
//  HotProspects
//
//  Created by Mehmet Ateş on 13.06.2022.
//

import SwiftUI

struct ImageInterpolation: View {
    var body: some View {
        VStack{
            Image("woman")
                .interpolation(.none)    
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .background(.black)
                .ignoresSafeArea()
        }
    }
}

struct ImageInterpolation_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolation()
    }
}
