//
//  MovieList.swift
//  Movie DB
//
//  Created by Varsha Soni on 27/06/25.
//

import Foundation
import UIKit


class MovieService {
    // create singleton object
    private init() {}
    static let shared = MovieService()
    // finish singleton
    let apiKey = "cb9889b063a8cf242679acac44adf03c"
    let baseHost = "api.themoviedb.org"
    let baseImageHost = "image.tmdb.org"
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    func getAuthenticatedUrl (withPath path: String, additionalQueryItems: [URLQueryItem] = []) -> URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = baseHost
        urlComponent.path = path
        urlComponent.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
        ] + additionalQueryItems
    
        let url = urlComponent.url!
        return url
    }
    
    func fetchUpcoming(apiTitle: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let path = "/3/movie/\(apiTitle)"
        let url = getAuthenticatedUrl(withPath: path, additionalQueryItems: [URLQueryItem(name: "page", value: "1")])
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, urlResponse, sessionError in
            if let error = sessionError {
                completion(.failure(error))
            } else if let httpResponse = urlResponse as? HTTPURLResponse,
                      !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NSError(domain: "MovieService", code: httpResponse.statusCode)))
            } else if let data = data {
                do {
                    let paginatedMovieResponse = try self.jsonDecoder.decode(PaginatedMovieResponse.self, from: data)
                    completion(.success(paginatedMovieResponse.results))
                } catch let catchError {
                    completion(.failure(catchError))
                }
            }
            
        }.resume()
        
    }
    
//    func getImageURL(path: String, dimension: Int = 200) -> URL {
//        var urlComponent = URLComponents()
//        urlComponent.scheme = "https"
//        urlComponent.host = baseImageHost
//        urlComponent.path = "/t/p/w\(dimension)" + path
//        let url = urlComponent.url!
//        return url
//    }
    
    func fetchImage(path: String, dimension: Int = 200, completion: @escaping (Result<UIImage, Error>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = baseImageHost
        urlComponent.path = "/t/p/w\(dimension)" + path
        let url = urlComponent.url!
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, urlResponse, sessionError in
            if let error = sessionError {
                completion(.failure(error))
            } else if let httpResponse = urlResponse as? HTTPURLResponse,
                      !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NSError(domain: "MovieService", code: httpResponse.statusCode)))
            } else if let data = data {
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NSError(domain: "MovieService", code: -1009)))
                }
            }
        }.resume()
    }
    
    func fetchGenres(_ completion: @escaping (Result<[Genre], Error>) -> Void) {
        let path = "/3/genre/movie/list"
        let url = getAuthenticatedUrl(withPath: path)
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
            } else if let httppResponse = urlResponse as? HTTPURLResponse,
                      !(200...299).contains(httppResponse.statusCode) {
                completion(.failure(NSError(domain: "MovieService", code: httppResponse.statusCode)))
            } else if let data = data {
                do {
                    let genreResponse = try
                    JSONDecoder().decode(GenreResponse.self, from: data)
                    completion(.success(genreResponse.genres))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchCredits(movieId: Int, dimension: Int = 200, completion: @escaping (Result<[Credit], Error>) -> Void) {
        let path = "/3/movie/\(movieId)/credits"
        let url = getAuthenticatedUrl(withPath: path)
        print(url)
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
            } else if let httppResponse = urlResponse as? HTTPURLResponse,
                      !(200...299).contains(httppResponse.statusCode) {
                completion(.failure(NSError(domain: "MovieService", code: httppResponse.statusCode)))
            } else if let data = data {
                do {
                    let creditresponse = try
                    JSONDecoder().decode(CreditResponse.self, from: data)
                    completion(.success(creditresponse.cast))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchReviews(movieId: Int, completion: @escaping (Result<[Reviews], Error>) -> Void) {
        let path = "/3/movie/\(movieId)/reviews"
        let url = getAuthenticatedUrl(withPath: path, additionalQueryItems: [URLQueryItem(name: "page", value: "1")])
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
            } else if let httppResponse = urlResponse as? HTTPURLResponse,
                      !(200...299).contains(httppResponse.statusCode) {
                completion(.failure(NSError(domain: "MovieService", code: httppResponse.statusCode)))
            } else if let data = data {
                do {
                    let reviewsResponse = try JSONDecoder().decode(PaginatedReviewResponse.self, from: data)
                    completion(.success(reviewsResponse.results))
                } catch {
                        completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
