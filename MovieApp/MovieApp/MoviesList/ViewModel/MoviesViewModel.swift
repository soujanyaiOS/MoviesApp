//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by soujanya Balusu on 24/05/22.
//

import Foundation
protocol MoviesViewModelInputProtocol {
    /// Method to fetch Movies list from server
    func getMovies()
}


class MoviesViewModel {
    // Input
    /// This variable will only allow input actions
    var input: MoviesViewModelInputProtocol { self }
    /// Network manager handle all the API calls
    var networkManager: NetworkManagerProtocol = NetworkManager()
    /// This Dynamic variable is used to notify reloadTable to update the UI on data change.
    var reloadTable: Dynamic<Bool> = Dynamic(false)
    /// Movies list object contains all Movies details
     var moviesList  : [MoviesElement]?

}

extension MoviesViewModel: MoviesViewModelInputProtocol {
    
    /// Retuen number of row that table view datasource need.
    func numberOfRows() -> Int {
        moviesList?.count ?? 0
    }

    ///Get Selected movie ID
    func getMovieID(index: Int) -> String {
        let obj: MoviesElement = moviesList![index] as MoviesElement
        return obj.id
    }
    
    
    ///GET MOVIES FROM SERVER CALL
    func getMovies() {
        if Reachability.isConnectedToNetwork(){
            networkManager.fetchMovies( completion: { [weak self] moviesListModel  in
                self?.moviesList = moviesListModel
                ///Chrological Sorting
                self?.moviesList?.sort {
                    $0.releaseDate > $1.releaseDate
                }
                self?.reloadTable.value = true
            })
        }else{
            debugPrint("Internet Connection not Available!")
        }
       
    }
}


    
  

