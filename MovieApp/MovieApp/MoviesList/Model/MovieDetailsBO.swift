//
//  MovieDetailsBO.swift
//  MovieApp
//
//  Created by soujanya Balusu on 25/05/22.
//

import Foundation
import SystemConfiguration
struct MovieDetails: Codable {
    let updatedAt: String
    let director, title: String
    let watchOrder: Int
    let createdAt: String
    let id: String
    let releaseDate: String
}


