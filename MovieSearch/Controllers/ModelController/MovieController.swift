//
//  MovieController.swift
//  MovieSearch
//
//  Created by Kaden Staker on 9/14/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    static let shared = MovieController()
    
    private init() {}
    
    var movies: [Movie] = []
    
    var baseURL = URL(string: "https://api.themoviedb.org/3")
    var imageBaseURL = URL(string: "http://image.tmdb.org/t/p/w500/")!
    
    func fetchMovie(by movieName: String, completion: @escaping ([Movie]?) -> Void) {
        
        guard let url = baseURL else {
            fatalError("Bad base url")
        }
        
        let searchURL = url.appendingPathComponent("search").appendingPathComponent("movie")
        
        var components = URLComponents(url: searchURL, resolvingAgainstBaseURL: true)
        let queryItem = URLQueryItem(name: "api_key", value: "e27ce1287c0998bb7d65434d0df67aa2")
        let queryItem2 = URLQueryItem(name: "language", value: "en-US") // This might be broken
        let queryItem3 = URLQueryItem(name: "query", value: movieName)
        components?.queryItems = [queryItem, queryItem2, queryItem3]
        
        guard let builtURL = components?.url else {return}
        
        URLSession.shared.dataTask(with: builtURL) { (data, _, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw NSError() }
                let movies = try JSONDecoder().decode(MoviesDictionary.self, from: data).movies
                self.movies = movies
                completion(movies)
            } catch let error {
                print("Error with data task: \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
        }.resume()
    }
    
    func fetchImage(movie: Movie, completion: @escaping (UIImage?) -> Void) {
        
        let posterURL = imageBaseURL.appendingPathComponent(movie.poster ?? "")
        
        URLSession.shared.dataTask(with: posterURL) { (data, _, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw NSError() }
                guard let image = UIImage(data: data) else { completion(nil); return}
                completion(image)
            } catch let error {
                print("Error fetching image: \(error.localizedDescription)")
            }
        }.resume()
    }
}


























