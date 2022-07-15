//
//  PopularMoviesCell.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 15.07.2022.
//

import UIKit

// MARK: Класс, описывающий ячейку Popular Movie
final class PopularMovieCell: UICollectionViewCell {

//    @IBOutlet weak var productImageView: UIImageView!
//    @IBOutlet weak var productNameLabel: UILabel!
//    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    var viewModel: PopularMovieCellViewModelProtocol! {
        didSet {
//            productImageView.image = UIImage(named: viewModel.productName)
//            productNameLabel.text = viewModel.productName
//            productDescriptionLabel.text = viewModel.productDescription
        }
    }
}
