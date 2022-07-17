//
//  TvShowCell.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 15.07.2022.
//

import UIKit

// MARK: Класс, описывающий ячейку TV Show
final class TvShowCell: UICollectionViewCell {

    
    @IBOutlet weak var tvShowImageView: UIImageView!
    @IBOutlet weak var tvShowTitleLabel: UILabel!
    @IBOutlet weak var tvShowReleaseDateLabel: UILabel!
    
    var viewModel: TvShowCellViewModelProtocol! {
        didSet {
//            productImageView.image = UIImage(named: viewModel.productName)
//            productNameLabel.text = viewModel.productName
//            productDescriptionLabel.text = viewModel.productDescription
        }
    }
}
