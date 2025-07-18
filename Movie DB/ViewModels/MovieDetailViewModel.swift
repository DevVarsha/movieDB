//
//  MovieDetailViewModel.swift
//  Movie DB
//
//  Created by Varsha Soni on 17/07/25.
//

import Foundation
import UIKit

class MovieDetailViewModel {
   var movie: Movie!

    func loadImage(at posterPath: String, completion: @escaping (UIImage?) -> Void) {
        let backdropPath = movie.backdropPath
        let posterPath = movie.posterPath
        let imageUrlPath = posterPath == "posterPath" ? posterPath : backdropPath
        
        MovieService.shared.fetchImage(path: imageUrlPath) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let failure):
                completion(nil)
            }
        }
    }
    
}
