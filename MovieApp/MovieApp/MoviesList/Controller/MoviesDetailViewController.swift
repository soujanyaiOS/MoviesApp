//
//  MoviesDetailViewController.swift
//  MovieApp
//
//  Created by soujanya Balusu on 24/05/22.
//

import UIKit

class MoviesDetailViewController: BaseViewController {

    @IBOutlet weak var updatedOnLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var createdOnLbl: UILabel!
    @IBOutlet weak var directorLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    var movieViewModel = MoviesDetailViewModel()
    var movieName: String = ""
    var movieId: String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movieName
        bindObjects()       
    }
    
    private func bindObjects() {
        movieViewModel.getMovieDetailsAPI(id: movieId) { [weak self ]success in
            if success {
                self?.titleLbl.text = self?.movieViewModel.movieObj?.title ?? ""
                self?.createdOnLbl.text = String(format: "%@%@", NSLocalizedString("CREATED", comment: ""),self?.movieViewModel.movieObj?.createdAt ?? "")
                self?.releaseDateLbl.text = String(format: "%@%@",NSLocalizedString("RELEASE", comment: ""),self?.movieViewModel.movieObj?.releaseDate ?? "")
                self?.directorLbl.text = String(format: "%@%@",NSLocalizedString("DIRECTOR", comment: ""),self?.movieViewModel.movieObj?.director ?? "")
                self?.updatedOnLbl.text = String(format: "%@%@", NSLocalizedString("MODIFIED", comment: ""),self?.movieViewModel.movieObj?.updatedAt ?? "")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = NSLocalizedString("MOVIE_DETAIL", comment: "")
    }

}
