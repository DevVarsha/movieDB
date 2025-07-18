//
//  ReviewViewModel.swift
//  Movie DB
//
//  Created by Varsha Soni on 17/07/25.
//
import Foundation

class ReviewViewModel {
    var movieId: Int = 0
    private var reviews: [Reviews] = []

    enum State {
        case initial
        case loading
        case loaded
        case error(Error)
    }
    
    var state: State = .initial {
        didSet {
            onChange?(state)
        }
    }
    
    var onChange: ((State) -> Void)?
    
    func bind(onChange: @escaping (State) -> Void) {
        self.onChange = onChange
    }
    
    func loadReview() {
        state = .loading
        MovieService.shared.fetchReviews(movieId: movieId) { result in
            switch result {
            case .success(let reviews):
                self.reviews = reviews
                DispatchQueue.main.async {
                    self.state = .loaded
                }
            case .failure(let failure):
                print(failure)
                self.state = .error(failure)
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return reviews.count
    }
    
    struct cellData {
    var autherName: String
    var contentLabel: String
    }
    
    func getReviewCellData(indexPath: IndexPath) -> cellData {
        let reviews = reviews
        let authName = reviews[indexPath.row].author
        let contentLabel = reviews[indexPath.row].content
        return cellData(
            autherName: authName,
            contentLabel: contentLabel
        )
        
    }
}
