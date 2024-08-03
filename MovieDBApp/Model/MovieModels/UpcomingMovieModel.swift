//
//  UpcomingMovieModel.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import Foundation

struct UpcomingResults: Codable {
    let page: Int
    let results: [UpcomingMovieModel]

    enum CodingKeys: String, CodingKey {
        case page, results
    }
}


struct UpcomingMovieModel: Codable, Identifiable {
    let adult: Bool
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let posterPath: String?
    let releaseDate, title: String

    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
    
    var fullPosterPath: String {
        guard let posterPath = posterPath else { return Constants.noImage }
        return Constants.imageGet + posterPath
    }
    
    static var mock: UpcomingMovieModel {
        UpcomingMovieModel(
            adult: false,
            id: 945961,
            originalLanguage: "en",
            originalTitle: "Alien: Romulus",
            overview: "While scavenging the deep ends of a derelict space station, a group of young space colonizers come face to face with the most terrifying life form in the universe.",
            posterPath: "/b33nnKl1GSFbao4l3fZDDqsMx0F.jpg",
            releaseDate: "2024-08-16",
            title: "Alien: Romulus"
        )
    }
}
