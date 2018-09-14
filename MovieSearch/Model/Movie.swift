//
//  Movie.swift
//  MovieSearch
//
//  Created by Kaden Staker on 9/14/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import Foundation

struct MoviesDictionary: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    let name: String
    let rating: Double
    let description: String
    let poster: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "title"
        case rating = "vote_average"
        case description = "overview"
        case poster = "poster_path"
    }
}
