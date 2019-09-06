//
//  RandomUserDetailedViewController.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/6/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class RandomUserDetailedViewController: UIViewController {

    var user:Users!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userAge: UILabel!
    @IBOutlet var userNumber: UILabel!
    @IBOutlet var userLocation: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDVC()
    }
    
    func setupDVC(){
        userName.text = user.name.convertFirstLetterOfNameToUpperCase()
        userAge.text = "\(user.dob.age) Years Old"
        userNumber.text = user.phone
        
        userImage.layer.borderWidth = 2
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        ImageHelper.shared.fetchImage(urlImage: user.picture.large) { (result) in
            switch result{
            case .failure(let error):
                print("Cant access Image \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.userImage.image = image
                }
            }
        }
    }

}
