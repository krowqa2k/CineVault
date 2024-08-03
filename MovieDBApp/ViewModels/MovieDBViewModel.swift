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
    @Published var popularActor: [PopularActorModel] = []
    @Published var airingToday: [AiringTodayModel] = []
    @Published var popularSeries: [PopularSeriesModel] = []
    @Published var onTheAirSeries: [OnTheAirSeriesModel] = []
    @Published var searchDB: [SearchDBModel] = []
    @Published var topRatedSeries: [TopRatedSeriesModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.sortTopRatedSeriesByRating()
            }
        }
    }
    
    @Published var upcoming: [UpcomingMovieModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.sortUpcomingMoviesByDate()
            }
        }
    }
    
    @Published var topRated: [TopRatedMovieModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.sortTopRatedMoviesByRating()
            }
        }
    }
    
    static let api_key: String = "5c7cea308def9c5b381b8e963b9df62a"
    
    
    init(){
        getTrendingsData()
        getPopularData()
        getUpcomingData()
        getTopRatedData()
        getPopularActorData()
        getAiringTodayData()
        getPopularSeriesData()
        getTopRatedSeriesData()
        getOnTheAirSeriesData()
        sortUpcomingMoviesByDate()
        sortTopRatedMoviesByRating()
        sortTopRatedSeriesByRating()
    }
    
    private func sortUpcomingMoviesByDate() {
        upcoming.sort { $0.releaseDate > $1.releaseDate }
    }
    
    private func sortTopRatedMoviesByRating() {
        topRated.sort { $0.voteAverage > $1.voteAverage}
    }
    
    private func sortTopRatedSeriesByRating() {
        topRatedSeries.sort { $0.voteAverage > $1.voteAverage}
    }
    
    func getYear(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        } else {
            return "Invalid date"
        }
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
    
    func getTopRatedData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(MovieDBViewModel.api_key)") else {return}
        
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
                    let decodedMovies = try JSONDecoder().decode(TopRatedResults.self, from: data)
                    self?.topRated = decodedMovies.results
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        .resume()
    }
    
    func getPopularActorData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/person/popular?api_key=\(MovieDBViewModel.api_key)") else {return}
        
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
                    let decodedMovies = try JSONDecoder().decode(PopularActorResult.self, from: data)
                    self?.popularActor = decodedMovies.results
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        .resume()
    }
    
    func getAiringTodayData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/airing_today?api_key=\(MovieDBViewModel.api_key)") else {return}
        
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
                    let decodedSeries = try JSONDecoder().decode(AiringTodayResult.self, from: data)
                    self?.airingToday = decodedSeries.results
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        .resume()
    }
    
    func getPopularSeriesData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/tv/day?api_key=\(MovieDBViewModel.api_key)") else {return}
        
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
                    let decodedSeries = try JSONDecoder().decode(PopularSeriesResults.self, from: data)
                    self?.popularSeries = decodedSeries.results
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        .resume()
    }
    
    func getTopRatedSeriesData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=\(MovieDBViewModel.api_key)") else {return}
        
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
                    let decodedSeries = try JSONDecoder().decode(TopRatedSeriesResults.self, from: data)
                    self?.topRatedSeries = decodedSeries.results
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        .resume()
    }
    
    func getOnTheAirSeriesData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/on_the_air?api_key=\(MovieDBViewModel.api_key)") else {return}
        
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
                    let decodedSeries = try JSONDecoder().decode(OnTheAirSeriesResults.self, from: data)
                    self?.onTheAirSeries = decodedSeries.results
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        .resume()
    }
    
    func getSearchDBData(query: String) {
        
        guard !query.isEmpty else { return }
                
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(MovieDBViewModel.api_key)&query=\(queryEncoded)") else {return}
        
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
                    let decodedDB = try JSONDecoder().decode(SearchDBResults.self, from: data)
                    self?.searchDB = decodedDB.results
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        .resume()
        
    }
}
