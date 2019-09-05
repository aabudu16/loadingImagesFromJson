//
//  AppError.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

enum AppError:Error{
    case badDJSONError
    case badURL
    case networkError
    case noDataError
    case badResponse
    case notFoundError // 404 status code
    case unauthorized // 403 and 401 status code
    case other (rawError:String)
    case badImage
    
}
