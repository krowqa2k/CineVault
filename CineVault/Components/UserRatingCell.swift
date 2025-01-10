//
//  UserRatingCell.swift
//  MovieDBApp
//
//  Created by Mateusz Krówczyński on 15/11/2024.
//

import SwiftData
import SwiftUI

struct UserRatingCell: View {
    let userRating: UserRatingModel
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ImageLoader(imageURL: imageName)
                .frame(width: 115, height: 160)
                .cornerRadius(12)
            
            UnevenRoundedRectangle(topLeadingRadius: 12, bottomTrailingRadius: 12)
                .frame(width: 30, height: 40)
                .foregroundStyle(.black.opacity(0.9))
                .overlay(alignment: .center) {
                    Text("\(userRating.rating)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.yellow)
                }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: UserRatingModel.self, configurations: config)
        let exampleRating = UserRatingModel(title: "Test Title", imageName: "https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg", rating: 8)
        
        return UserRatingCell(userRating: exampleRating, imageName: exampleRating.imageName)
    } catch {
        return Text("Failed to create preivew: \(error.localizedDescription).")
    }
}
