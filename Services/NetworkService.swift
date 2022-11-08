//
//  NetworkService.swift
//  Hotel
//
//  Created by Vadlet on 02.11.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

protocol NetworkServiceProtocol: AnyObject {
    func fetchImageData(imageID: String, completion: @escaping (Data) -> Void)
    func fetchHotelsData<T: Decodable>(dataType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func fetchHotelData<T: Decodable>(id: String, dataType: [T.Type], completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "0777.json"
    private let url = "https://raw.githubusercontent.com/iMofas/ios-android-test/master/"
    
    func fetchHotelsData<T: Decodable>(dataType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        fetchData(from: url + baseURL) { (result: Result<T, NetworkError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchHotelData<T: Decodable>(id: String, dataType: [T.Type], completion: @escaping (Result<T, Error>) -> Void) {
        fetchData(from: url + id + ".json") { (result: Result<T, NetworkError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchImageData(imageID: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: url + imageID) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no description")
                return
            }
            DispatchQueue.main.async {
                completion(data)
            }
        }
        .resume()
    }
    
    private func fetchData<T: Decodable>(from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "no description")
                return
            }
            
            do {
                let hotelList = try JSONDecoder().decode(T.self, from: data)
                completion(.success(hotelList))
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
