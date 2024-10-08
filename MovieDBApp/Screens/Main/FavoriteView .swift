//
//  FavoriteView .swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 03/08/2024.
//

import SwiftUI

struct FavoriteView_: View {
    
    @EnvironmentObject var viewModel: MovieDBViewModel
    let columns = [GridItem(.adaptive(minimum: 110, maximum: 160))]
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(spacing: 12) {
                HStack {
                    HStack {
                        Text("Your Favorites!")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.purpleDB)
                        Image(systemName: "heart.fill")
                            .font(.title2)
                            .foregroundStyle(.purpleDB)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    
                    Image(systemName: "popcorn.fill")
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                        .padding(.trailing)
                }
                .padding(.top)
                if viewModel.favoriteMoviesAndSeries.isEmpty {
                    Spacer()
                    HStack(spacing: 0) {
                        Image(systemName: "movieclapper")
                            .font(.system(size: 100))
                            .foregroundStyle(.red)
                        Image(systemName: "questionmark")
                            .font(.system(size: 100))
                            .foregroundStyle(.red)
                    }
                    Text("No favorites added yet!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.purpleDB)
                } else {
                    Text("ℹ️ If you want to delete favorite Movie/Series, just press and hold image for one second!")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 12)
                        .padding(.horizontal)
                    
                    ScrollView(.vertical) {
                        LazyVGrid(columns: columns, alignment: .leading) {
                            ForEach(Array(viewModel.favoriteMoviesAndSeries), id: \.self){ favorite in
                                ImageLoader(imageURL: favorite)
                                    .frame(width: 110, height: 160)
                                    .cornerRadius(12)
                                    .simultaneousGesture(
                                        LongPressGesture(minimumDuration: 0.5).onEnded({ _ in
                                            withAnimation(.bouncy(duration: 0.5)) {
                                                removeFavorite(item: favorite)
                                            }
                                        })
                                    )
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                }
                Spacer()
                
                Spacer()
            }
        }
    }
    
    private func removeFavorite(item: String) {
        viewModel.favoriteMoviesAndSeries.remove(item)
    }
}

#Preview {
    FavoriteView_()
        .environmentObject(MovieDBViewModel())
}
