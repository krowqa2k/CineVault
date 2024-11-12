//
//  PopularSeriesDetailView.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 01/08/2024.
//

import SwiftUI

struct SeriesDetailView: View {
    
    @EnvironmentObject var viewModel: MovieDBViewModel
    var imageName: String = Constants.mockImage
    var series: SeriesModel = .mock
    @State private var onClick: Bool = false
    @State private var userRating: Int = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                ImageLoader(imageURL: imageName).ignoresSafeArea(edges: .top)
                    .frame(height: UIScreen.main.bounds.height / 1.7, alignment: .top)
                    .overlay (
                        imageOverlay
                        ,alignment: .bottom
                    )
                
                VStack {
                    HStack {
                        ForEach(1...10, id: \.self) { star in
                            Image(systemName: star <= userRating ? "star.fill" : "star")
                                .font(.title2)
                                .foregroundStyle(LinearGradient(colors: [.white,.yellow,.orange], startPoint: .topTrailing, endPoint: .bottomLeading))
                                .onTapGesture { userRating = star }
                        }
                    }
                }
                .padding([.bottom, .horizontal])
                
                ScrollView(.vertical){
                    Text(series.overview ?? "")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                }
            }
            .overlay(
                dismissButton
                ,alignment: .topLeading
            )
            .overlay(
                addToFavoritesButton
                ,alignment: .topTrailing
            )
        }
        .onAppear(perform: {
            updateOnClickState()
        })
        .toolbar(.hidden, for: .navigationBar)
    }
    private func updateOnClickState() {
        onClick = viewModel.favoriteMoviesAndSeries.contains(series.fullPosterPath)
    }
    
    private var imageOverlay: some View {
        VStack(alignment: .leading) {
            Text(series.adult ?? false ? "18+" : "")
                .frame(width: 40, height: 40)
                .font(.headline)
                .foregroundStyle(.blackDB)
                .background(series.adult ?? false ? Color.red : .clear)
                .cornerRadius(12)
                .padding(.horizontal)
            
            Text(series.name ?? "")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.horizontal)
            HStack(alignment: .bottom) {
                Text("\(series.firstAirYear)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                HStack {
                    Text("User reviews")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                    Image(systemName: "star.fill")
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.2f", series.voteAverage ?? 0))
                        .font(.headline)
                        .foregroundStyle(.yellow)
                }
                .opacity(series.voteAverage != 0 ? 1:0)
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: 100)
        .padding(.bottom)
        .background(
            LinearGradient(colors: [Color.blackDB.opacity(0.001), Color.blackDB.opacity(1)], startPoint: .top, endPoint: .bottom)
        )
        
    }
    
    private var dismissButton: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundStyle(.blackDB.opacity(0.8))
            .overlay(
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
            )
            .padding()
            .onTapGesture {
                dismiss()
            }
    }
    
    private var addToFavoritesButton: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundStyle(.blackDB.opacity(0.8))
            .overlay(
                Image(systemName: "heart.fill")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(onClick ? .red : .white)
            )
            .padding()
            .onTapGesture {
                if viewModel.favoriteMoviesAndSeries.contains(series.fullPosterPath){
                    viewModel.favoriteMoviesAndSeries.remove(series.fullPosterPath)
                    viewModel.removeFavorite(posterPath: series.fullPosterPath)
                } else {
                    viewModel.favoriteMoviesAndSeries.insert(series.fullPosterPath)
                    viewModel.addFavorite(posterPath: series.fullPosterPath)
                }
                onClick.toggle()
            }
    }
}

#Preview {
    SeriesDetailView()
        .environmentObject(MovieDBViewModel())
}
