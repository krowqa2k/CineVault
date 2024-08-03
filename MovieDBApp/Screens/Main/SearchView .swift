//
//  SearchView .swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 02/08/2024.
//

import SwiftUI

struct SearchView_: View {
    @StateObject private var viewModel = MovieDBViewModel()
    @State private var query: String = ""
        
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(spacing: 8) {
                searchBar
                    .padding(.top)
                Spacer()
                moviesResult
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        
        
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundStyle(.purpleDB)
                .padding(.leading)
                .padding(.trailing, 0)
            TextField("Search movies", text: $query) {
                viewModel.getSearchDBData(query: query)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.trailing,12)
            .padding(.leading, 0)
            .frame(maxWidth: .infinity)
        }
    }
    
    private var moviesResult: some View {
        ScrollView(.vertical) {
            ForEach(viewModel.searchDB) { row in
                NavigationLink(destination: SearchMovieDetailScreen(imageName: row.fullPosterPath, movie: row)) {
                    HStack(spacing: 12) {
                        ImageLoader(imageURL: row.fullPosterPath)
                            .frame(width: 110, height: 160)
                            .cornerRadius(16)
                        VStack(alignment: .leading, spacing: 8){
                            Text(row.title ?? "")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.leading)
                            Text(viewModel.getYear(from: row.releaseDate ?? ""))
                                .font(.system(size: 14))
                                .foregroundStyle(.gray)
                        }
                        .frame(maxHeight: 150, alignment: .top)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ZStack {
        Color.blackDB.ignoresSafeArea()
        SearchView_()
    }
}
