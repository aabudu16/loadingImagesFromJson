//
//  PokemonApiClient.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation
import UIKit

struct PokemonApiClient{
    static let shared = PokemonApiClient()
    
    let pokemonURL = "https://api.pokemontcg.io/v1/cards"
    
  func fetchData(completionHandler: @escaping (Result<[Cards], AppError>)->()){
    NetworkManager.shared.fetchData(urlString: pokemonURL) { (result) in
        switch result{
        case .failure(let error):
            completionHandler(.failure(error))
        case .success(let data):
            do{
               let pokemon = try JSONDecoder().decode(pokemonWrapper.self, from: data)
                completionHandler(.success(pokemon.cards))
            }catch{
                completionHandler(.failure(.noDataError))
            }
        }
    }
    }
}
