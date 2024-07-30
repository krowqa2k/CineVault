//
//  MovieDBAppApp.swift
//  MovieDBApp
//
//  Created by admin on 25/07/2024.
//

import SwiftUI

@main
struct MovieDBAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MovieDBViewModel())
        }
    }
}
