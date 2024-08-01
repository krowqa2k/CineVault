//
//  OnTheAirSeriesModel.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import Foundation

struct OnTheAirSeriesResults: Codable {
    let page: Int
    let results: [OnTheAirSeriesModel]
}

struct OnTheAirSeriesModel: Codable, Identifiable {
    let adult: Bool
    let id: Int
    let originalLanguage, overview: String
    let posterPath, name: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case name
        case voteAverage = "vote_average"
    }
    
    var fullPosterPath: String {
            Constants.imageGet + posterPath
        }
    
    static var mock: OnTheAirSeriesModel {
        OnTheAirSeriesModel(
            adult: false,
            id: 1234,
            originalLanguage: "en",
            overview: "overview",
            posterPath: "jakis tam poster",
            name: "House Of Dragon",
            voteAverage: 7.68
        )
    }
}
