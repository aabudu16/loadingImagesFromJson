//
//  ComicViewController.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/6/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController {
     @IBOutlet var comicNumberlabel: UILabel!
    @IBOutlet var comicImage: UIImageView!
    @IBOutlet var comicTextField: UIView!
    @IBOutlet var comicStepper: UIStepper!
    
    var randomNumber = RandomNumberGen.randomNumber(){
        didSet {
            DispatchQueue.main.async {
                self.setImage()
            }
        }
    }
    
    var mostRecent:Comics!
    var comic:Comics!{
            didSet {
                DispatchQueue.main.async {
                    self.setImage()
                }
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComicData(number: nil)
    }
    
    func setImage(){
        ImageHelper.shared.fetchImage(urlImage: comic.img) { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    self.comicImage.image = image
                }
                
            }
        }
    }
    
    func fetchComicData(number:Int?){
        ComicAPIClient.shared.fetchData(num: number) { (result) in
            switch result{
            case .failure(let error):
                print("Cant retrieve image \(error)")
            case .success(let comic):
                DispatchQueue.main.async {
                    self.comic = comic
                    self.mostRecent = comic
                }
            }
        }
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag{
        case 0:
            comic = mostRecent
        case 1:
            randomNumber = RandomNumberGen.randomNumber()
            fetchComicData(number: randomNumber)
            comicNumberlabel.text = String(randomNumber)
            comicStepper.value = Double(randomNumber)
        default:
            randomNumber = -1
        }
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        randomNumber = Int(sender.value)
        fetchComicData(number: randomNumber)
        comicNumberlabel.text = String(Int(sender.value))
    }
    
}


