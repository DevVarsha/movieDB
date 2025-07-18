//
//  CreditsViewModel.swift
//  Movie DB
//
//  Created by Varsha Soni on 17/07/25.
//

import Foundation
import UIKit

class CreditsViewModel {
    var credits: [Credit] = []
    var movieId: Int = 0

    enum State {
        case initial
        case loading
        case loaded
        case error(Error)
    }
    
    private var movies: [Movie] = []
    var state: State = .initial {
        didSet {
            onChange?(state)
        }
    }
    
    var onChange: ((State) -> Void)?
    
    func bind(onChange: @escaping (State) -> Void) {
        self.onChange = onChange
    }
    
    func loadCredits() {
        state = .loading
        MovieService.shared.fetchCredits(movieId: movieId) { result in
            switch result {
            case .success(let credits):
                self.credits = credits
                DispatchQueue.main.async {
                    self.state = .loaded
                }
            case .failure(let failure):
                print(failure)
                self.state = .error(failure)
            }
        }
    }

    struct CreditsDisplayData {
        let profilePath: String
        let nameLabel: String
        let subNameLabel: String
    }
    
    func fetchcellData(at indexPath: IndexPath) -> CreditsDisplayData  {
        let creditIndex = credits[indexPath.row]
        return CreditsDisplayData(
            profilePath: creditIndex.profilePath ?? "",
            nameLabel: creditIndex.name,
            subNameLabel: creditIndex.knownForDepartment
        )
    }
    
    func loadImage(at profilePath: String, completion: @escaping (UIImage?) -> Void) {
        MovieService.shared.fetchImage(path: profilePath) { result in
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
