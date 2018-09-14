//
//  MoviesTableViewController.swift
//  MovieSearch
//
//  Created by Kaden Staker on 9/14/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
//        loadMovies()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.shared.movies.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell

        let movie = MovieController.shared.movies[indexPath.row]
        
        cell.movie = movie
        
        MovieController.shared.fetchImage(movie: movie) { (image) in
            DispatchQueue.main.async {
                cell.posterImageView.image = image
            }
        }
        return cell
    }
   
    func loadMovies() {
        guard let movieText = searchBar.text?.lowercased() else {return}
        MovieController.shared.fetchMovie(by: movieText) { (movie) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
            searchText != "" && searchText != " " else {return}
        MovieController.shared.fetchMovie(by: searchText) { (movie) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
