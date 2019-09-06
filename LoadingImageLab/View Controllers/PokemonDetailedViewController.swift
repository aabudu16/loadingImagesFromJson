//
//  PokemonDetailedViewController.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class PokemonDetailedViewController: UIViewController {
    var pokemon:Cards!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var type: UITextView!
    @IBOutlet var weaknesses: UITextView!
    @IBOutlet var set: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDVC()
    }
    
    func setupDVC(){
        name.text = pokemon.name
        set.text = pokemon.set
        type.text = pokemon.types?.reduce("", ({$0 + $1}))
        
        //weaknesses.text = pokemon.weaknesses![0].type
        ImageHelper.shared.fetchImage(urlImage: pokemon.imageUrlHiRes) { (result) in
            switch result{
            case .failure(let error):
                print("cant retrieve image \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        }
    }
    
    
}
