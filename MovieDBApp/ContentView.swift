//
//  ContentView.swift
//  MovieDBApp
//
//  Created by admin on 25/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: MovieDBViewModel
    
    var body: some View {
        VStack {
            List{
                ForEach(viewModel.trendings){ trendingMovie in
                    Text(trendingMovie.title)
                }
            }
        }
        .padding()
    }
}

class MovieDBViewModel: ObservableObject {
    
    @Published var trendings: [TrendingMovieModel] = []
    static let api_key: String = "5c7cea308def9c5b381b8e963b9df62a"
    
    init(){
        getData()
    }
    
    static var mock: TrendingMovieModel {
        TrendingMovieModel(
            id: 123,
            title: "Deadpool & Wolverine",
            description: "some description",
            posterPath: "123452525",
            adult: true,
            releaseDate: "26/07/2024",
            voteAverage: 8.2
        )
    }
    
    func getData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=\(MovieDBViewModel.api_key)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("No data.")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response.")
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code should be 2xx, but is \(response.statusCode)")
                return
            }
            
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                do {
                    let decodedMovies = try JSONDecoder().decode(TrendingResults.self, from: data)
                    self?.trendings = decodedMovies.results
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        .resume()
    }
    
}

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
}

#Preview {
    ContentView(viewModel: MovieDBViewModel())
}
