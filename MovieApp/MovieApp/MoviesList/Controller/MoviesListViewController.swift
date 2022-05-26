//
//  MoviesListViewController.swift
//  MovieApp
//
//  Created by soujanya Balusu on 24/05/22.
//

import UIKit
import Combine
class MoviesListViewController: BaseViewController {
    var viewModel = MoviesViewModel()
    var ​tokenString​: String = ""
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        loadInitialSubViews()
        viewModel.getMovies()
        bindObjects()
    }

    /// Method to set all binding object functionality
    private func bindObjects() {
        viewModel.reloadTable.bind { [weak self] shouldReload in
            if shouldReload {
                self?.tableView.reloadData()
            }
        }
    }
    
    ///LOAD VIEW SET UP VIEWS
    func loadInitialSubViews() {        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        constraints()        
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = NSLocalizedString("MOVIES_TITLE", comment: "")
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MoviesTableViewCell
        let obj: MoviesElement = viewModel.moviesList![indexPath.row] as MoviesElement
        cell.configureCell(viewModel: obj)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainSB.instantiateViewController(withIdentifier: "MoviesDetailViewController") as! MoviesDetailViewController
        vc.movieId = viewModel.getMovieID(index: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
