//
//  RandomUserViewController.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import UIKit

class RandomUserViewController: UIViewController {
    
    var randomUser = [Users](){
        didSet {
            DispatchQueue.main.async {
                self.randomUserTableView.reloadData()
            }
        }
    }
    
    var userSearchString:String? = nil{
        didSet{
            setResultCount()
            self.randomUserTableView.reloadData()
        }
    }
    
    var userSearchResult:[Users]{
        get {
            guard let searchString = userSearchString else {return randomUser}
            
            guard searchString != "" else {return randomUser}
            
            return randomUser.filter({$0.name.convertFirstLetterOfNameToUpperCase().lowercased().replacingOccurrences(of: " ", with: "").contains(searchString.lowercased().replacingOccurrences(of: " ", with: ""))})
        }
    }
    
    private func setResultCount(){
        switch userSearchResult.count{
        case randomUser.count:
            if userSearchString != ""{
                navigationItem.title = "You have \(userSearchResult.count) results"
            }else{
                navigationItem.title = "Random Users"
            }
        case 1:
            navigationItem.title = "You have 1 result"
        case 0:
            navigationItem.title = "You have no results"
        default:
            navigationItem.title = "You have \(userSearchResult.count) results"
        }
    }
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var randomUserTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchUserData()
    }
    
    private func setupView(){
        randomUserTableView.delegate = self
        randomUserTableView.dataSource = self
        searchBar.delegate = self
        navigationItem.title = "Random Users"
        navigationController?.navigationBar.backgroundColor = .green
    }
    private func  fetchUserData(){
        RandomUserAPIClient.shared.fetchData { (result) in
            switch result{
            case .failure(let error):
                print("cant retrieve data \(error)")
            case .success(let user):
                self.randomUser = user.sorted(by: {$0.name.first < $1.name.first})
            }
        }
    }
}

extension RandomUserViewController: UITableViewDelegate{}
extension RandomUserViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSearchResult.count
    }
    func makeImageRound(imageView:UIImageView){
       imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "randomUserCell") as? RandomUserUITableViewCell else {return UITableViewCell()}
        
        let info = userSearchResult[indexPath.row]
        
        cell.userName.text = info.name.convertFirstLetterOfNameToUpperCase()
        cell.userAge.text = "\(info.dob.age) Years Old"
        cell.userPhoneNumber.text = info.phone
        
        makeImageRound(imageView: cell.userImage)
        ImageHelper.shared.fetchImage(urlImage: info.picture.medium) { (result) in
            switch result{
            case .failure(let error):
                print("cant get image \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.userImage.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let randomUserDVC = storyboard?.instantiateViewController(withIdentifier: "RandomUserDVC") as? RandomUserDetailedViewController else {return}
        
        let info = userSearchResult[indexPath.row]
        
        randomUserDVC.user = info
        
        self.navigationController?.pushViewController(randomUserDVC, animated: true)
    }
}
extension RandomUserViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        userSearchString = searchBar.text
    }
}
