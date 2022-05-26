//
//  ServerHost.swift
//  MovieApp
//
//  Created by soujanya Balusu on 26/05/22.
//

import Foundation

struct API {
    static let baseUrl = "https://iosdevtest.herokuapp.com/"
    static let movieListEndpoint = "api/movies/"
    static let loginEndpoint = "api/login/"
}
struct URLHost: RawRepresentable {
    var rawValue: String
}
extension URLHost {
    static var staging: Self {
        URLHost(rawValue: API.baseUrl)
    }

    static var production: Self {
        URLHost(rawValue: API.baseUrl)
    }

    static var `default`: Self {
        #if DEBUG
        return staging
        #else
        return production
        #endif
    }
}
