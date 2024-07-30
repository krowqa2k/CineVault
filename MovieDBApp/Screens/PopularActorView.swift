//
//  PopularActorView.swift
//  MovieDBApp
//
//  Created by admin on 30/07/2024.
//

import SwiftUI

struct PopularActorView: View {
    
    @StateObject var viewModel: MovieDBViewModel = MovieDBViewModel()
    
    var body: some View {
        ZStack {
            Color.blackDB.ignoresSafeArea()
            
            VStack(spacing: 8) {
                HStack() {
                    Text("Popular Actors")
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
                        ForEach(viewModel.popularActor){ popularActor in
                            PopularActorCell(actor: popularActor, imageURL: popularActor.fullPosterPath)
                                .onTapGesture {
                                    
                                }
                        }
                    }
                }
                .frame(maxHeight: 260)
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    PopularActorView()
}
