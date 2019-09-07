//
//  ComicAPIClient.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/6/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

struct ComicAPIClient{
    static let shared = ComicAPIClient()
    
    func fetchData(num:Int?, completionHandler: @escaping (Result<Comics,AppError>) -> ()){
        
        var comicURL = "http://xkcd.com/300/info.0.json"
        
        
        if let number = num {
              comicURL = "http://xkcd.com/\(number)/info.0.json"
        }
        NetworkManager.shared.fetchData(urlString: comicURL) { (result) in
            switch result{
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                
                do {
                    let comicData = try JSONDecoder().decode(Comics.self, from: data)
                    completionHandler(.success(comicData))
                }catch{
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}
