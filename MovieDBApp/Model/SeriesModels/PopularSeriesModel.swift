//
//  PopularSeriesModel.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import Foundation

struct PopularSeriesResults: Codable {
    let page: Int
    let results: [PopularSeriesModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct PopularSeriesModel: Codable, Identifiable {
    let adult: Bool
    let id: Int
    let originalLanguage, overview: String
    let posterPath: String?
    let name: String
    let firstAirDate: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case name
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
    }
    
    var fullPosterPath: String {
        guard let posterPath = posterPath else { return Constants.noImage }
        return Constants.imageGet + posterPath
    }
    
    static var mock: PopularSeriesModel {
        PopularSeriesModel(
            adult: false,
            id: 1234,
            originalLanguage: "en",
            overview: "overview",
            posterPath: "jakis tam poster",
            name: "House Of Dragon",
            firstAirDate: "2022/08/23",
            voteAverage: 7.68
        )
    }
}
