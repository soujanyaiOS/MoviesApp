//
//  NetworkManager.swift
//  MovieApp
//
//  Created by soujanya Balusu on 24/05/22.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol {
    func fetchMovies( completion: @escaping ([MoviesElement]?) -> Void)
    func loginAPI(with username:String,password: String,completion: @escaping (login?) -> Void)
    func getMovieDetailsAPI(with id:String,completion: @escaping (MovieDetails?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
let host: URLHost = .default
    //MARK: - FETCH MOVIE API ACTION
    func fetchMovies( completion: @escaping ([MoviesElement]?) -> Void) {
        guard let url =  URL(string: host.rawValue + API.movieListEndpoint)  else{
            return
        }
        let movieRequest = getrequestHeaders(url)
        let dateFormatter = DateFormatter()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        URLSession.shared.dataTask(with: movieRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            let result = try? decoder.decode([MoviesElement].self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(result)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    
    //MARK: - LOGIN API ACTION
    func loginAPI(with username:String,password: String,completion: @escaping (login?) -> Void) {
        guard let url =  URL(string: host.rawValue + API.loginEndpoint)  else{
            return
        }
        var movieRequest = URLRequest( url: url)
        let base64EncodedCredential = (username + ":" + password)
            .data(using: .utf8)!
            .base64EncodedString()
        movieRequest.addValue("Basic " + base64EncodedCredential, forHTTPHeaderField: "Authorization")
        movieRequest.httpMethod = "POST"
        movieRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: movieRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            let result = try? JSONDecoder().decode(login.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(result)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    ///GET HEADERS
    private  func getrequestHeaders(_ url: URL) -> URLRequest{
        var movieRequest = URLRequest( url: url)
        let bearerToken:String = String(format:"%@",UserDefaults.standard.string(forKey: "accessToken") ?? "")
        movieRequest.httpMethod = "GET"
        movieRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        movieRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return movieRequest
    }
    
    //MARK: - Get Movie Details
    func getMovieDetailsAPI(with id:String,completion: @escaping (MovieDetails?) -> Void) {
        guard let url =  URL(string: host.rawValue + API.movieListEndpoint +  "\(id)")  else{
            return
        }
        let movieRequest = getrequestHeaders(url)
        URLSession.shared.dataTask(with: movieRequest) { (data, response, error) in
            guard let data = data, error == nil else {
                debugPrint("hello \(String(describing: error?.localizedDescription))")
                return
            }
            let result = try? JSONDecoder().decode(MovieDetails.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(result)
                }
            } else {
                DispatchQueue.main.async {
                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                        appDelegate.resetRoot()
                    }
                }
            }
        }.resume()
    }
}

