//
//  ViewController.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 20.06.2022.
//

import UIKit

class ViewController: UIViewController {

    private var popularMovie = PopularMovie()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
    }

    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: popularMovieAPI) {  popularMovie in
            self.popularMovie = popularMovie
//            self.tableView.reloadData()
        }
    }
}
