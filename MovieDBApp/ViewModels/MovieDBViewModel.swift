//
//  MovieDBViewModel.swift
//  MovieDBApp
//
//  Created by admin on 26/07/2024.
//

import Foundation

class MovieDBViewModel: ObservableObject {
    
    @Published var trendings: [TrendingMovieModel] = []
    @Published var popular: [PopularMovieModel] = []
    @Published var upcoming: [UpcomingMovieModel] = [] {
    didSet {
        DispatchQueue.main.async {
            self.sortUpcomingMoviesByDate()
        }
    }
}
    
    static let api_key: String = "5c7cea308def9c5b381b8e963b9df62a"
    
    
    init(){
        getTrendingsData()
        getPopularData()
        getUpcomingData()
        sortUpcomingMoviesByDate()
    }
    
    private func sortUpcomingMoviesByDate() {
        upcoming.sort { $0.releaseDate > $1.releaseDate }
    }
    
    
    func getTrendingsData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(MovieDBViewModel.api_key)") else {return}
        
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
    
    func getPopularData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(MovieDBViewModel.api_key)") else {return}
        
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
                    let decodedMovies = try JSONDecoder().decode(PopularMovieResults.self, from: data)
                    self?.popular = decodedMovies.results
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        .resume()
    }
    
    func getUpcomingData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(MovieDBViewModel.api_key)") else {return}
        
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
                    let decodedMovies = try JSONDecoder().decode(UpcomingResults.self, from: data)
                    self?.upcoming = decodedMovies.results
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        .resume()
    }
}
