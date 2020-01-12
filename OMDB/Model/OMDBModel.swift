//
//  OMDBModel.swift
//  OMDB
//
//  Created by Zappfresh on 12/01/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit

// MARK: - OMDBModel
class OMDBModel: Codable {
    let search: [Search]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }

    init(search: [Search], totalResults: String, response: String) {
        self.search = search
        self.totalResults = totalResults
        self.response = response
    }
}

// MARK: - Search
class Search: Codable {
    let title, year, imdbID: String
    let type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }

    init(title: String, year: String, imdbID: String, type: String, poster: String) {
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.type = type
        self.poster = poster
    }
}

