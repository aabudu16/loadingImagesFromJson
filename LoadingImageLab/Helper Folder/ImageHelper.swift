//
//  ImageHelper.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper{
    static let shared = ImageHelper()
    public init() {}
    func fetchImage(urlImage:String, complitionHandler: @escaping (Result<UIImage, AppError>) -> ()){
        NetworkManager.shared.fetchData(urlString: urlImage) { (result) in
            switch result{
            case .failure:
                fatalError()
            case .success(let data):
                guard let imaage = UIImage(data: data) else{
                    complitionHandler(.failure(.badImage))
                    return
                }
                complitionHandler(.success(imaage))
            }
        }
    }
}
