//
//  ViewController.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemon = [Cards](){
        didSet{
            DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
            }
        }
    }
    @IBOutlet var pokemonTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchPokemonData()
    }
    
    func setupView(){
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
    }
    func fetchPokemonData(){
        PokemonApiClient.shared.fetchData { (result) in
            switch result{
            case .failure(let error):
                print("cant retrieve data \(error)")
            case .success(let card):
                self.pokemon = card
                
            }
        }
    }
}

extension PokemonViewController: UITableViewDelegate{}
extension PokemonViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell") as? PokemonTableViewCell else {return UITableViewCell()}
        
        let info = pokemon[indexPath.row]
        
        ImageHelper.shared.fetchImage(urlImage: info.imageUrl) { (result) in
            switch result{
            case .failure(let error):
                print("cant load Image \(error)")
            case .success(let image):
                
                DispatchQueue.main.async {
                     cell.pokemonImage.image = image
                }
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemonDVC = storyboard?.instantiateViewController(withIdentifier: "pokemonDVC") as? PokemonDetailedViewController else {return}
        
        let info = pokemon[indexPath.row]
        
        pokemonDVC.pokemon = info
        
        self.navigationController?.pushViewController(pokemonDVC, animated: true)
    }
}
