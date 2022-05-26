//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by soujanya Balusu on 25/05/22.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    lazy var namelbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.backgroundColor = .clear
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 15.0)
        return lbl
    }()
    
    lazy var releaseDate: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.backgroundColor = .clear
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.backgroundColor = .white
        addSubview(namelbl)
        addSubview(releaseDate)
        namelbl.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        namelbl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor , constant: 10).isActive = true
        namelbl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor , constant: -10).isActive = true
        namelbl.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        
        releaseDate.topAnchor.constraint(equalTo: namelbl.topAnchor, constant: 35).isActive = true
        releaseDate.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor , constant: 10).isActive = true
        releaseDate.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor , constant: -10).isActive = true
        releaseDate.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
        // Configure the view for the selected state
    }
    
    func configureCell(viewModel: MoviesElement?) {
        namelbl.text = viewModel?.title ?? ""
        releaseDate.text =  String(format: "%@@",viewModel?.releaseDate ?? "" )        
    }
   
    
}
