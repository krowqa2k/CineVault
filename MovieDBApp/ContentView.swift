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
        ZStack {
            Color.blackDB.ignoresSafeArea()
            ScrollView() {
                HeaderView()
                LazyVStack(spacing: 16) {
                    
                    LatestMovieView()
                    
                    PopularMovieView()
                    
                    UpcomingMovieView()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}


#Preview {
    ContentView(viewModel: MovieDBViewModel())
}
