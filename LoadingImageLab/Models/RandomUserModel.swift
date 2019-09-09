//
//  RandomUserModel.swift
//  LoadingImageLab
//
//  Created by Mr Wonderful on 9/5/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

struct RandomUserWrapper:Codable{
    let results:[Users]
}

struct Users:Codable{
    let name:Names
    let location:Locations
    let dob:DOB
    let phone:String
    let cell:String
    let picture:Pictures
}

struct Names:Codable{
    let title:String
    let first:String
    let last:String
    
    func convertFirstLetterOfNameToUpperCase() -> String{
        let fullName = "\(title.capitalizingFirstLetter()) \(first.capitalizingFirstLetter()) \(last.capitalizingFirstLetter())"
        return fullName
    }
}
struct Locations:Codable{
    let street:String
    let city:String
    let state:String
    var fullAddress:String {
        return "\(street) \(city) \(state)"
    }
}
struct DOB:Codable{
    let age:Int
}
struct Pictures:Codable{
    let  large:String
    let medium:String
    let thumbnail:String
}
