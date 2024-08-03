//
//  ContentView.swift
//  MovieDBApp
//
//  Created by admin on 25/07/2024.
//

import SwiftUI

struct MainView: View {
    
    @State var index: Int
    @StateObject var viewModel: MovieDBViewModel
    @State private var options: [String] = ["Movies", "Series"]
    @AppStorage("db_home_filter") private var selection: String = "Movies"
    
    var body: some View {
    ZStack {
        Color.blackDB.ignoresSafeArea()
            VStack {
                switch index {
                case 0:
                    defaultView
                    .scrollIndicators(.hidden)
                case 1:
                    SearchView_()
                case 2:
                    FavoriteView_()
                case 3:
                    AppInfoView()
                default :
                    defaultView
                    .scrollIndicators(.hidden)
                }
                Spacer()
                        
                TabView(index: self.$index)
                    .frame(height: 45)
            }
        }
    }
    
    private var defaultView: some View {
        ScrollView {
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
                } else {
                    LazyVStack(spacing: 16) {
                        OnTheAirSeriesView()
                        PopularSeriesView()
                        AiringTodaySeriesView()
                        TopRatedSeriesView()
                    }
                    .transition(.move(edge: .trailing))
                }
            }
            .animation(.spring(), value: selection)
        }
    }
}


#Preview {
    MainView(index: 0, viewModel: MovieDBViewModel())
}
