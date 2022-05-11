//
//  HabitModel.swift
//  HabitTracker
//
//  Created by Mehmet Ateş on 11.05.2022.
//

import Foundation

struct HabitModel: Identifiable, Codable{
    var id = UUID()
    
    // MARK: Inputs
    var name: String // adı
    var description: String // açıklama
    var type: String // türü
    var createDate: Date // başlama tarihi
    var dailyTimeTarget: Int // günlük ne kadar zaman harcamayı planlıyorsun
    var dailywastedTime: Int? // ne kadar zaman harcadın
    var frequency: Int? // kaç günde bir yapmayı düşünüyorsun
    
    // MARK: Calculated
    var todayState: Bool{
        let todayComponents = Calendar.current.dateComponents([.day, .month, .year], from: Date.now)
        let lastModifycomponents = Calendar.current.dateComponents([.day, .month, .year], from: lastModify)
        return ((lastModifycomponents.day) == (todayComponents.day)) && ((lastModifycomponents.month) == (todayComponents.month)) && ((lastModifycomponents.year) == (todayComponents.year)) && (dailyTimeTarget == (dailywastedTime ?? 0))
    } // bugün çalışma yapıldı mı?
    var lastModify: Date // en son ne zaman çalışıldı?
    var totalWastedTime: Int? // toplam ne kadar zaman harcadın?
    var continuityRate: Double? // devamlılık oranın?
}
