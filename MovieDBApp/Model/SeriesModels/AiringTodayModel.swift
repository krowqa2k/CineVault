//
//  AiringTodayModel.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import Foundation

struct AiringTodayResult: Codable {
    let page: Int
    let results: [AiringTodayModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct AiringTodayModel: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let posterPath, firstAirDate, name: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var fullPosterPath: String {
            Constants.imageGet + posterPath
        }
    
    static var mock: AiringTodayModel {
        AiringTodayModel(
            adult: false,
            backdropPath: "/AbLzUrHtZ0WbvgYQsD0bMzitYEW.jpg",
            genreIDS: [9648],
            id: 211089,
            originCountry: ["cn"],
            originalLanguage: "zh",
            originalName: "krzaczki",
            overview: "overview",
            popularity: 2123213,
            posterPath: "/sgv6nwj1TlDDKqxbcUEuds8fqoz.jpg",
            firstAirDate: "2022-09-27",
            name: "Strange Tales Of Tang Dynasty",
            voteAverage: 8,
            voteCount: 17
        )
    }
}
