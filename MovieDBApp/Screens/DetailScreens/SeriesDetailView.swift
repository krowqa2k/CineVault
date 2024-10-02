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
            HStack {
                Text(series.adult ?? false ? "18+" : "")
                    .frame(width: 40, height: 40)
                    .font(.headline)
                    .foregroundStyle(.blackDB)
                    .background(series.adult ?? false ? Color.red : .clear)
                    .cornerRadius(12)
                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                        .font(.headline)
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.2f", series.voteAverage ?? ""))
                        .font(.headline)
                        .foregroundStyle(.yellow)
                }
                .padding(4)
                .background(Color.blackDB)
                .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Text(series.name ?? "")
                .font(.system(size: 26))
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.horizontal)
            
            Text("First Aired on: \(series.firstAirDate ?? "No Data :(")")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
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
