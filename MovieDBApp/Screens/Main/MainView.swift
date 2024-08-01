//
//  ContentView.swift
//  MovieDBApp
//
//  Created by admin on 25/07/2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MovieDBViewModel
    @State private var options: [String] = ["Movies", "Series"]
    @AppStorage("db_home_filter") private var selection: String = "Movies"
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            ScrollView() {
                HeaderView()
                    
                FilterView(options: options, selection: $selection)
                    .padding()
                
                ZStack {
                    if selection == "Movies" {
                        LazyVStack(spacing: 16) {
                                
                            LatestMovieView()
                                
                            PopularMovieView()
                                
                            UpcomingMovieView()
                                
                            TopRatedMovieView()
                                
                            PopularActorView()
                        }
                        .transition(.move(edge: .leading))
                        
                    }
                    else {
                       LazyVStack(spacing: 16) {
                               
                           AiringTodaySeriesView()
                               
                           PopularSeriesView()
                               
                           UpcomingMovieView()
                               
                           TopRatedMovieView()
                               
                           PopularActorView()
                       }
                       .transition(.move(edge: .trailing))
                   }
                }
                .animation(.spring, value: selection)
            }
            .scrollIndicators(.hidden)
        }
    }
}


#Preview {
    MainView(viewModel: MovieDBViewModel())
}
