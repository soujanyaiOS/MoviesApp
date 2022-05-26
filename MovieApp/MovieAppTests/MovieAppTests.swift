//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by soujanya Balusu on 24/05/22.
//

import XCTest
@testable import MovieApp

class MovieAppTests: XCTestCase {
    var moviesViewModel: MoviesViewModel?

    override func setUpWithError() throws {
        moviesViewModel = MoviesViewModel()
        moviesViewModel?.networkManager = NetworkManagerMock()
    }
    
    override func tearDownWithError() throws {
        moviesViewModel = nil
    }
    
    ///TEST FOR MOVIES LIST ROWS IN TABLE
    func testMoviesListNumberOfRows() {
        // given
        moviesViewModel?.input.getMovies()
        // when
        let numberofrows = moviesViewModel?.numberOfRows()
        // then
        XCTAssertEqual(numberofrows, 27, "Number of rows should be zero")
    }
    
    ///TEST FOR BINDING DATA RELOAD ON API COMPLETION
    ///Movies List
    func testGetMovies() {
        // given
        // when
        moviesViewModel?.input.getMovies()
        // then
        XCTAssertTrue(moviesViewModel?.reloadTable.value ?? false, "")
    }
    
    ///TEST FOR MOVIES LIST ROWS IN TABLE
    func testslectedMovieID() {
        // given
        moviesViewModel?.input.getMovies()
        // when
        let obj = moviesViewModel?.getMovieID(index: 1)
        // then
        XCTAssertEqual(obj, "B2303AF9-0861-42B3-9D4A-9836886039E6", "id matches")
    }
    
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}

class NetworkManagerMock: NetworkManagerProtocol {
    func fetchMovies(completion: @escaping ([MoviesElement]?) -> Void) {
        let model = Bundle(for: type(of: self)).decode([MoviesElement].self, from: "Movies")
        completion(model)
    }
    
    func loginAPI(with username: String, password: String, completion: @escaping (login?) -> Void) {
        let model = Bundle(for: type(of: self)).decode(login.self, from: "login")
        completion(model)
    }
    
    func getMovieDetailsAPI(with id: String, completion: @escaping (MovieDetails?) -> Void) {
        let model = Bundle(for: type(of: self)).decode(MovieDetails.self, from: "MoviesDetails")
        completion(model)
    }
    
    
}
