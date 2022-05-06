//
//  TabBarButtonView.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 6.05.2022.
//

import SwiftUI

struct TabBarButtonView: View {
    @Binding var currentTab : String
    var title : String
    var image : String
    private var isSelected: Bool{
        return title == currentTab
    }
    
    var body: some View{
        Button{
            withAnimation{
                currentTab = title
            }
        }label: {
            VStack(spacing: 5){
                Image(systemName: image)
                    .font(.body)
                Text(title)
                    .fontWeight(isSelected ? .bold: .regular)
            }.font(.caption)
                .foregroundColor(isSelected ? .orange: .secondary)
                .frame(maxWidth: .infinity)
        }
    }
}
