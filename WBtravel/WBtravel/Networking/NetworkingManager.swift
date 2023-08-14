//
//  NetworkingManager.swift
//  WBtravel
//
//  Created by Olga on 13.08.2023.
//

import Foundation
import UIKit

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private let urlString = "https://vmeste.wildberries.ru/stream/api/avia-service/v1/suggests/getCheap"
    
    private let dataRaw = ["startLocationCode":"LED"]
    
    private var flightsData = FlightsData(flights: [Flight]())
    
    func request(activityIndicator: UIActivityIndicatorView, completion: @escaping (Result <FlightsData, Error>) -> Void) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let urlRequest = urlForUrlRequest() else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(FlightsData.self, from: data)
                    completion(.success(result))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                }
            }
        }.resume()
    }
    
    private func urlForUrlRequest() -> URLRequest? {
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let data = try? JSONSerialization.data(withJSONObject: dataRaw, options: .sortedKeys)
        request.httpBody = data

        return request
    }
}
