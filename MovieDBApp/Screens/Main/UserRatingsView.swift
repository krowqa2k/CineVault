//
//  FavoriteView .swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 03/08/2024.
//

import SwiftData
import SwiftUI

struct UserRatingsView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query() var userRatings: [UserRatingModel]
    
    let columns = [GridItem(.adaptive(minimum: 110, maximum: 160))]
    @EnvironmentObject var viewModel: MovieDBViewModel
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            VStack(spacing: 12) {
                HStack {
                    HStack {
                        Text("Your Ratings")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.purpleDB)
                        if #available(iOS 18.0, *) {
                            Image(systemName: "star.fill")
                                .font(.title2)
                                .foregroundStyle(.yellow)
                                .symbolEffect(.bounce.down.byLayer, options: .repeat(.periodic(delay: 0.5)))
                        } else {
                            Image(systemName: "star.fill")
                                .font(.title2)
                                .foregroundStyle(.yellow)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    
                    Image(systemName: "popcorn.fill")
                        .font(.system(size: 25))
                        .foregroundStyle(.white)
                        .padding(.trailing)
                }
                .padding(.top)

                if userRatings.isEmpty {
                    Spacer()
                    HStack(spacing: 0) {
                        Image(systemName: "movieclapper")
                            .font(.system(size: 100))
                            .foregroundStyle(.red)
                        Image(systemName: "questionmark")
                            .font(.system(size: 100))
                            .foregroundStyle(.red)
                    }
                    Text("No movie rated yet!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.purpleDB)
                } else {
                    Text("ℹ️ If you want to delete Movie/Series, just press and hold image for one second!")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 12)
                        .padding(.horizontal)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, alignment: .leading) {
                            ForEach(userRatings) { movie in
                                UserRatingCell(userRating: movie, imageName: movie.imageName)
                                    .simultaneousGesture(
                                        LongPressGesture(minimumDuration: 0.5).onEnded { _ in
                                            withAnimation(.bouncy(duration: 0.5)) {
                                                removeRating(model: movie)
                                            }
                                        }
                                    )
                            }
                            .padding(.horizontal, 4)
                        }
                    }
                }
                Spacer()
            }
        }
    }
    
    private func removeRating(model: UserRatingModel) {
        do {
            modelContext.delete(model)
            try modelContext.save()
        } catch {
            print("Error removing rating: \(error.localizedDescription)")
        }
    }
}

#Preview {
    UserRatingsView()
        .environmentObject(MovieDBViewModel())
}
