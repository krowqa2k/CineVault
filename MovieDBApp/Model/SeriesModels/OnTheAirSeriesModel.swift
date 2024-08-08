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
    let adult: Bool?
    let id: Int?
    let originalLanguage, overview: String?
    let posterPath: String?
    let name: String?
    let voteAverage: Double?
    let firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case name
        case voteAverage = "vote_average"
        case firstAirDate = "first_Air_Date"
    }
    
    var fullPosterPath: String {
        guard let posterPath = posterPath else { return Constants.noImage }
        return Constants.imageGet + posterPath
    }
    
    static var mock: OnTheAirSeriesModel {
        OnTheAirSeriesModel(
            adult: false,
            id: 1234,
            originalLanguage: "en",
            overview: "overview",
            posterPath: "jakis tam poster",
            name: "House Of Dragon",
            voteAverage: 7.68,
            firstAirDate: "2022/08/06"
        )
    }
}
