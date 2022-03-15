//
//  Note.swift
//  Day74-Challenge
//
//  Created by Mehmet Ateş on 15.03.2022.
//

import UIKit

class Note: NSObject, Codable {
    var id: Int
    var title: String
    var detail: String
    
    init (id: Int, title : String, detail : String){
        self.id = id
        self.title = title
        self.detail = detail
    }
}
