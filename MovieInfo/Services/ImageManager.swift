//
//  ImageManager.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 16.07.2022.
//

import Foundation
import UIKit

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageData(from imagePath: String) -> UIImage? {
//        guard let imagePath = imagePath else { return nil }
        let url = URL(string: imagePath)
        guard let url = url else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        guard let image = UIImage(data: imageData) else { return nil }
        return image
    }
}
