//
//  ObjectCollectionView-ViewModel.swift
//  ObjectPhotoList
//
//  Created by Mehmet Ateş on 10.06.2022.
//

import Foundation
import UIKit

extension ObjectCollectionView{
    @MainActor class ObjectCollectionViewModel: ObservableObject{
        let userDefaults = UserDefaults.standard
        
        @Published var objects: Array<ObjectModel> = []{
            didSet{
                handleObjects()
            }
        }
        @Published var sheetImagePicker: Bool = false
        @Published var alertToggle: Bool = false
        
        @Published var pickedImage: UIImage?
        @Published var pickedName: String = ""
        
        
        init(){
            getObject()
        }
        
        func saveModel(){
            guard let pickedImage = pickedImage?.jpegData(compressionQuality: 0.8) else { return }
            guard pickedName != "" else { return }
            
            let object = ObjectModel(name: pickedName, imageData: pickedImage)
            objects.append(object)
        }
        
        func handleObjects(){
            DispatchQueue.main.async{
                if let encoded = try? JSONEncoder().encode(self.objects){
                    self.userDefaults.set(encoded, forKey: "object")
                }
            }
            if !(objects.count < 2) {
                objects.sort { $0.name > $1.name }
            }
        }
        
        func getObject(){
            if let savedItems = UserDefaults.standard.data(forKey: "object"){
                if let decodedItems = try? JSONDecoder().decode([ObjectModel].self, from: savedItems){
                    objects = decodedItems
                    return
                }
            }
            
            objects = []
        }
    }
}
