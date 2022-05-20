//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Mehmet Ateş on 18.05.2022.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16
    
    var body: some View {
        VStack(spacing: 0){
            Text(rating.formatted())
                .foregroundColor(setContentColor(bookPoint: rating))
            Image(systemName: setContentIcon(bookPoint: rating))
                .foregroundColor(.yellow)
                .font(.caption2)
        }
    }
    
    func setContentColor(bookPoint: Int16) -> Color{
        if bookPoint < 2{
            return .red
        }else if bookPoint < 4{
            return .orange
        }
        return .green
    }
    
    func setContentIcon(bookPoint: Int16) -> String{
        if bookPoint < 2{
            return "star"
        }else if bookPoint < 4{
            return "star.leadinghalf.filled"
        }
        return "star.fill"
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
