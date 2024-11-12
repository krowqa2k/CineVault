//
//  String.swift
//  MovieDBApp
//
//  Created by Mateusz on 12/11/2024.
//

import Foundation

extension String {
    func extractYearFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return "\(year)"
        } else {
            return "Unknown Year"
        }
    }
}

