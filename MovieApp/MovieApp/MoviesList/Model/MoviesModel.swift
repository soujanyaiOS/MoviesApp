//
//  MoviesModel.swift
//  MovieApp
//
//  Created by soujanya Balusu on 24/05/22.
//

import Foundation
struct MoviesElement: Codable {
    let id: String
    let watchOrder: Int
    let title: String
    let releaseDate: String
}

typealias movies = [MoviesElement]

extension MoviesElement {
    /// Convert the releaseDate to an actual date type later will be used for comparison
    var convertedStartDate: Date {
        return dateFormatter.date(from: releaseDate) ?? Date()
    }
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }
}
