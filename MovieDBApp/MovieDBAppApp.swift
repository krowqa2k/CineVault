//
//  MovieDBAppApp.swift
//  MovieDBApp
//
//  Created by admin on 25/07/2024.
//

import SwiftUI

@main
struct MovieDBAppApp: App {
    
    @StateObject private var viewModel = MovieDBViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainView(index: 0)
            }
            .environmentObject(viewModel)
        }
    }
}
