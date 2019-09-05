//
//  PokemonModel.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct pokemonWrapper:Codable{
    let cards:[Cards]
}

struct Cards:Codable {
    let name:String
    let imageUrl:String
    let imageUrlHiRes:String
    let types:[String]?
    let set:String
    let weaknesses:[Weaknesses]?
}

struct Weaknesses:Codable{
    let type:String
    let value:String
}


