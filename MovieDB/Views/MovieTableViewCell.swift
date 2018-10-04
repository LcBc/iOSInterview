//
//  OfflineTableViewCell.swift
//  MovieDB
//
//  Created by Luis Barrios on 10/2/18.
//  Copyright © 2018 Luis Barrios. All rights reserved.
//

import UIKit
import Kingfisher
class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    var movie:Movie?{
        didSet{
        updateCell()
        }
    }
    
    private func updateCell(){
        nameLabel.text = movie?.title
        descriptionLabel.text = movie?.overview
        avgLabel.text = "AVG: \(movie?.vote_average ?? 0)"
        voteCountLabel.text = "Vote Count: \(movie?.vote_count ?? 0)"
        if let posterPath = movie?.poster_path,
            let url = URL(string: posterBaseURL + posterPath) {
            poster.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
