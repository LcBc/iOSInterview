//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Luis Barrios on 10/3/18.
//  Copyright © 2018 Luis Barrios. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var movie:Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let posterPath = movie?.poster_path,
            let url = URL(string: posterBaseURL + posterPath) {
            poster.kf.setImage(with: url)
        }
        if let backgroundPath = movie?.backdrop_path,  let url = URL(string: posterBaseURL + backgroundPath) {
            backgroundImage.kf.setImage(with: url)
        }

        let genreStrings:[String] =  movie?.genres?.compactMap{
            if let genre = $0 as? Genre{
                return genre.name
            }
            return nil
            } ?? [String]()
       
        
        genreLabel.text = "Genres: \(genreStrings.joined(separator: ","))"
        
        titleLabel.text = movie?.title
        descriptionLabel.text = movie?.overview
        avgLabel.text = "AVG: \(movie?.vote_average ?? 0)"
        voteCountLabel.text = "Vote Count: \(movie?.vote_count ?? 0)"
        popularityLabel.text = "Popularity: \(movie?.popularity ?? 0)"
        originalTitleLabel.text = movie?.original_title
        originalLanguageLabel.text = "Original Language: \(movie?.original_language ?? "")"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let dateString = formatter.string(from: movie?.release_date ?? Date())
        releaseLabel.text = "Release:  \(dateString)"
        
        
    }

    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
