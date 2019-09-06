//
//  RandomUserAPIClient.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

struct RandomUserAPIClient{
    static let shared = RandomUserAPIClient()
    
    let RandonUserURL = "https://randomuser.me/api/?page=3&results=100&seed=abc"
    
    func fetchData(completionHandler:@escaping (Result<[Users],AppError>) -> ()){
        
        NetworkManager.shared.fetchData(urlString: RandonUserURL) { (result) in
            switch result{
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(RandomUserWrapper.self, from: data)
                    completionHandler(.success(user.results))
                } catch{
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}
