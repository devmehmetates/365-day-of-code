//
//  UsingSwiftUICharts.swift
//  NewFeaturesOnSwiftUI
//
//  Created by Mehmet Ateş on 8.06.2022.
//

import SwiftUI
import Charts

struct ValuePerCategory: Identifiable {
    var id = UUID()
    var category: String
    var value: Double
}

struct UsingSwiftUICharts: View {
    let data: [ValuePerCategory] = [
        .init(category: "A", value: 2),
        .init(category: "B", value: 10),
        .init(category: "C", value: 5),
        .init(category: "D", value: 12),
        .init(category: "E", value: 20),
        .init(category: "F", value: 32),
        .init(category: "G", value: 27),
        .init(category: "H", value: 45),
        .init(category: "I", value: 50)
    ]
    
    var body: some View {
        ScrollView{
            Group{
                ChartCard("Line-Mark") {
                    Chart(data) {
                        LineMark(x: .value("Deneme", $0.category), y: .value("Deneme", $0.value))
                            .foregroundStyle(.red)
                    }
                }
                
                ChartCard("Bar-Mark") {
                    Chart(data) {
                        BarMark(x: .value("Deneme", $0.category), y: .value("Deneme", $0.value))
                            .foregroundStyle(Gradient(colors: [.blue, .teal]))
                            .annotation(alignment: .top) {
                                Image(systemName: "star")
                                    .foregroundColor(.teal)
                            }
                    }
                }
                
                ChartCard("Area-Mark") {
                    Chart(data) {
                        AreaMark(x: .value("Deneme", $0.category), y: .value("Deneme", $0.value))
                            .foregroundStyle(.orange)
                    }
                }
                
                ChartCard("Rule-Mark") {
                    Chart(data) {
                        RuleMark(x: .value("Deneme", $0.value), yStart: 0, yEnd: 50)
                    }
                }
                
                ChartCard("Point-Mark") {
                    Chart(data) {
                        PointMark(x: .value("Deneme", $0.category), y: .value("Deneme", $0.value))
                            .foregroundStyle(.red)
                    }
                }
                
                ChartCard("Rectangle-Mark") {
                    Chart(data) {
                        RectangleMark(x: .value("Deneme", $0.category), y: .value("Deneme", $0.value))
                            .foregroundStyle(.red)
                    }
                }
            }.frame(maxWidth: .infinity)
        }
    }
}

struct UsingSwiftUICharts_Previews: PreviewProvider {
    static var previews: some View {
        UsingSwiftUICharts()
    }
}

struct ChartCard<Content: View>: View{
    private var content: Content
    private var title: String
    
    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            Text(title)
                .foregroundColor(.secondary)
            content
                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.width * 0.4, alignment: .center)
                .padding()
                .background(Color.white)
                .cornerRadius(10.0)
                .shadow(radius: 7.0)
                .padding(.vertical)
        }
    }
}
