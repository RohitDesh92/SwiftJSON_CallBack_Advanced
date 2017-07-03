//
//  User.swift
//  JSON_IOS
//
//  Created by Rohit Deshmukh on 7/1/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import Foundation

struct User:Decodable, Equatable {
    
    let email:String
    let firstName:String
    let lastName:String
    let middleName:String?
    let rating:Int
    let userid:Int
    
    var userFullName:String {
        
        return "\(self.firstName) \(self.lastName)"
    }
    
//    {
//    "email": "rohitdesh92@gmail.com",
//    "fname": "Rohit",
//    "lname": "Deshmukh",
//    "mname": "Subhashrao",
//    "rating": 3,
//    "uid": 1
//    }
    
    //Gloss for parsing
    init?(json:JSON) {
        
       guard let email:String = "email" <~~ json,
        let fname:String = "fname" <~~ json,
        let lname:String = "lname" <~~ json,
        let mname:String = "mname" <~~ json,
        let rating:Int = "rating" <~~ json,
        let uid:Int = "uid" <~~ json
        else {
            
            return nil
        }
        
        self.email = email
        self.firstName = fname
        self.lastName = lname
        self.middleName = mname
        self.rating = rating
        self.userid = uid
        
    }
    
    public static func ==(lhs:User, rhs:User) -> Bool {
        
        return lhs.userid == rhs.userid
    }
}
