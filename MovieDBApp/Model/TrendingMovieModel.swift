//
//  TrendingMovieModel.swift
//  MovieDBApp
//
//  Created by admin on 26/07/2024.
//

import Foundation

struct TrendingResults: Codable {
    let page: Int
    let results: [TrendingMovieModel]
    let total_pages: Int
    let total_results: Int
}

struct TrendingMovieModel: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String
    let posterPath: String
    let adult: Bool
    let releaseDate: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case posterPath = "poster_path"
        case adult
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    var fullPosterPath: String {
            Constants.imageGet + posterPath
        }
    
    static var mock: TrendingMovieModel {
        TrendingMovieModel(
            id: 123,
            title: "Deadpool & Wolverine",
            description: "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
            posterPath: "123452525",
            adult: true,
            releaseDate: "26/07/2024",
            voteAverage: 8.2
        )
    }
    
}
