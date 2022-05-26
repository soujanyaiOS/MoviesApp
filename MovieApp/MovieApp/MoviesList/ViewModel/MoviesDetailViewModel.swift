//
//  MoviesDetailViewModel.swift
//  MovieApp
//
//  Created by soujanya Balusu on 25/05/22.
//

import Foundation
protocol MoviesDetailViewModelInputProtocol {
    /// Method to fetch Movies detail from server based on ID Param
    func getMovieDetailsAPI(id: String, callback: @escaping (_ success: Bool) -> Void)
}

class MoviesDetailViewModel {
    // Input
    /// This variable will only allow input actions
    var input: MoviesDetailViewModelInputProtocol { self }
    /// Network manager handle all the API calls
    var networkManager: NetworkManagerProtocol = NetworkManager()
    /// This Dynamic variable is used to notify reloadTable to update the UI on data change.
    var reloadData: Dynamic<Bool> = Dynamic(false)
    /// Movies list object contains all Movies details
    var movieObj  : MovieDetails?
    
}

extension MoviesDetailViewModel: MoviesDetailViewModelInputProtocol {
    ///API CALL TO GET MOVIE DETAILS FOR SELECTED ID
    func getMovieDetailsAPI(id: String, callback: @escaping (_ success: Bool) -> Void) {
        if Reachability.isConnectedToNetwork(){
            networkManager.getMovieDetailsAPI(with: id,completion: { [weak self] movieDetails in
                self?.movieObj = movieDetails
                self?.reloadData.value = true
                callback(true)
            })
        }else{
            debugPrint("Internet Connection not Available!")
        }
        
    }
}
