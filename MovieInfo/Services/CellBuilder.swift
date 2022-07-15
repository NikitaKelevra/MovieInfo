//
//  CellBuilder.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 15.07.2022.
//

import Foundation

//import UIKit

/// Протокол строителя
protocol CellBuildable {
    /// Настраивает ячейки
    func configureCell(for cell: PopularMovieCell,
                       with popularMovieCellViewModel: PopularMovieCellViewModelProtocol)
    func configureCell(for cell: TvShowCell,
                       with tvShowCellViewModel: TvShowCellViewModelProtocol)
}

/// Строитель ячеек
final class CellBuilder {}

// MARK: - CellBuildable
extension CellBuilder: CellBuildable {
    func configureCell(for cell: PopularMovieCell, with popularMovieCellViewModel: PopularMovieCellViewModelProtocol) {
        
        cell.viewModel = popularMovieCellViewModel
        
//        cell.productImageView.contentMode = .scaleAspectFill
//        cell.backgroundColor = .blue
    }
    
    func configureCell(for cell: TvShowCell, with tvShowCellViewModel: TvShowCellViewModelProtocol) {
        
        cell.viewModel = tvShowCellViewModel
        
//        cell.specialOfferImageView.contentMode = .scaleAspectFill
//        cell.backgroundColor = .green
        
    }
}
