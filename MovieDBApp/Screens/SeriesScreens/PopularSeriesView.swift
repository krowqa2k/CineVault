//
//  PopularSeriesView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI

struct PopularSeriesView: View {
    @StateObject var viewModel: MovieDBViewModel = MovieDBViewModel()
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                VStack(spacing: 8) {
                    HStack() {
                        Text("Popular Series")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Text("View all")
                                .font(.subheadline)
                                .foregroundStyle(.purpleDB)
                        })
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal){
                        LazyHStack {
                            ForEach(viewModel.popularSeries){ popularSeries in
                                NavigationLink(destination: PopularSeriesDetailView(imageName: popularSeries.fullPosterPath, movie: popularSeries)) {
                                    PopularSeriesCell(movie: popularSeries, imageURL: popularSeries.fullPosterPath)
                                }
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 280)
                    .scrollIndicators(.hidden)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
}

#Preview {
    PopularSeriesView()
}
