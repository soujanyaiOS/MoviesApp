//
//  StringExtensions.swift
//  MovieApp
//
//  Created by soujanya Balusu on 26/05/22.
//

import Foundation

extension String {
    func getDate(_ withString: String)-> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")//Add this
        let date = dateFormatter.date(from: withString)
        return date ?? Date()
    }
}
