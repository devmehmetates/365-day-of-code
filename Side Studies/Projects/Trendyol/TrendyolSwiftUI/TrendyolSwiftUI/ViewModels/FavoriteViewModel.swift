//
//  FavoriteViewModel.swift
//  TrendyolSwiftUI
//
//  Created by Mehmet Ateş on 23.05.2022.
//

import Foundation
import CoreData

class FavoriteViewModel: ObservableObject{
    
    func saveFavorite(_ moc: NSManagedObjectContext){
        do{
            var product = Product(context: moc)
            product.brand = "MSI"
            product.desc = "27 OPTIC GAMING MONITOR"
            product.discount = true
            product.imageURL = "https://cdn.dsmcdn.com/ty200/product/media/images/20211015/12/148587584/162028127/1/1_org_zoom.jpg"
            product.isFavorite = true
            product.price = 2386.15
            product.reviewPoint = 5
            
            try moc.save()
        }catch{
            print("save error triggered")
        }
        
    }
}
