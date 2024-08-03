//
//  FavoriteView .swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 03/08/2024.
//

import SwiftUI

struct FavoriteView_: View {
    
    @StateObject var viewModel: MovieDBViewModel = MovieDBViewModel()
    
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
                Spacer()
                if viewModel.favoriteMoviesAndSeries.isEmpty {
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
                }
                Spacer()
                
                Spacer()
            }
        }
    }
}

#Preview {
    FavoriteView_()
}
