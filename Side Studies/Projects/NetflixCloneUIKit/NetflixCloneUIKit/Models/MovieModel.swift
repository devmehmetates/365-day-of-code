//
//  MovieModel.swift
//  NetflixCloneUIKit
//
//  Created by Mehmet Ateş on 2.05.2022.
//

import Foundation

struct MovieModel: Codable{
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let title: String
    let releaseDate: String
    let posterPath: String
    
    private enum CodingKeys : String , CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case title = "title"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
