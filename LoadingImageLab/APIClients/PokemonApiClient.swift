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
    
  func fetchData(complitionHandler: @escaping (Result<[Cards], AppError>)->()){
    NetworkManager.shared.fetchData(urlString: pokemonURL) { (result) in
        switch result{
        case .failure(let error):
            complitionHandler(.failure(error))
        case .success(let data):
            do{
               let pokemon = try JSONDecoder().decode(pokemonWrapper.self, from: data)
                complitionHandler(.success(pokemon.cards))
            }catch{
                complitionHandler(.failure(.noDataError))
            }
        }
    }
    }
}
