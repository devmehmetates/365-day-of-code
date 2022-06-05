//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Mehmet Ateş on 5.06.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
