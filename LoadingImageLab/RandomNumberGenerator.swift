//
//  RandomNumberGenerator.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/6/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct RandomNumberGen{
   static func randomNumber() -> Int{
        let newNum = Int.random(in: 0 ... 2000)
        return newNum
    }
}
