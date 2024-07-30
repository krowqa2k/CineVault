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
                    
                LazyVStack(spacing: 16) {
                        
                    LatestMovieView()
                        
                    PopularMovieView()
                        
                    UpcomingMovieView()
                        
                    TopRatedMovieView()
                        
                    PopularActorView()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}


#Preview {
    MainView(viewModel: MovieDBViewModel())
}
