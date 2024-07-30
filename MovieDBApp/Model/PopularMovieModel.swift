//
//  PopularMovieModel.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import Foundation

struct PopularMovieResults: Codable {
    let page: Int
    let results: [PopularMovieModel]
}

struct PopularMovieModel: Codable, Identifiable {
    let adult: Bool
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
    
    var fullPosterPath: String {
            Constants.imageGet + posterPath
        }
    
    static var mock: PopularMovieModel {
        PopularMovieModel(
            adult: true,
            id: 123,
            originalTitle: "Deadpool & Wolverine",
            overview: "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine.",
            popularity: 7220.83,
            posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            releaseDate: "2024-07-26",
            title: "Deadpool & Wolverine",
            voteAverage: 8.072
        )
    }
}


