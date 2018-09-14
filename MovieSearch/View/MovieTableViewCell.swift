//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by Kaden Staker on 9/14/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    var movie: Movie? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        guard let movie = movie else {return}
        nameLabel.text = movie.name
        ratingLabel.text = "Rating: \(movie.rating)"
        descriptionLabel.text = movie.description
    }
}
