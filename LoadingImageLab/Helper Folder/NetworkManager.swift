//
//  NetworkManager.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.

import Foundation

class NetworkManager {
    // TODO: - we'll update this to cache
    private init (){}
    
    static let shared = NetworkManager()
    
    // performs GET requests
    // Parameters: URL as a String
    //Complitions: Result with Data in success, AppError in Failure
    
    func fetchData (urlString:String, complitionHandler: @escaping (Result<Data,AppError>) -> ()){
        guard let url = URL(string: urlString) else {
            complitionHandler(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                complitionHandler(.failure(.networkError))
                return
            }
            guard let data = data else {
                complitionHandler(.failure(.noDataError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                complitionHandler(.failure(.badResponse))
                return
            }
            
            switch response.statusCode{
            case 404:
                complitionHandler(.failure(.notFoundError))
            case 401, 403:
                complitionHandler(.failure(.unauthorized))
            case 200...299:
                complitionHandler(.success(data))
            default:
                complitionHandler(.failure(.other(rawError: "Wrong Status Code")))
            }
            }.resume()
    }
    
}
