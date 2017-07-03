//
//  NetworkManager.swift
//  JSON_IOS
//
//  Created by Rohit Deshmukh on 7/1/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import Foundation


class NetworkManager {
    
    let usersJsonFilename = "Users"
    let usersUrl = "http://localhost:8080/Cooking_App_Server/webapi/users/"
    let someotherURl = "http://"
    
    //Get all users
    //    (id:Int,name:String)->Void
    
    func parseUser(json:Any) -> [User]? {
        
        var usersArray:[User] = []
        
        if json is Dictionary<String, Any> {
            
            let user:User = User.init(json: json as! JSON)!
            
            usersArray = [user]
        }
        else if (json is Array<Dictionary<String,Any>>) {
            
            //This array of dictionaries
            
            guard let array = [User].from(jsonArray: json as! [JSON]) else {
                
                print("Failure in Parsing User ")
                //failure(nil)
                return nil
            }
            
            usersArray = array
        }
        
        return usersArray
    }
    
    func getAllUsers(success:@escaping (Any)->Void, failure:@escaping (Error)->Void) {
        
        _ = fireApi(urlString:usersUrl, success:{ json in
            
            let usersArray = self.parseUser(json: json)
            
            success(usersArray!)
            
        }, failure:{ error in
            
            failure(error)
        })
    }
    
    func mockUsersData(success:@escaping (Any)->Void, failure:@escaping (Error)->Void) {
        
        let dictionary = Utilities.readFile(usersJsonFilename)
        
        var usersArray = self.parseUser(json: dictionary)
        
        
        if let usersArray = usersArray {
            
            //success
            success(usersArray)
        }
        else {
            
            //failure
            failure(fatalError("usersArray failed parsing") as! Error)
        }
    }
    
    // MARK: Session function
    func fireApi(urlString:String, success:@escaping (Any)->Void, failure:@escaping (Error)->Void) -> Any {
        
        guard let url = URL(string: urlString) else {return ""}
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse{
                
                if response.statusCode == 200 {
                    
                    print("Response Successful:\(response)")
                }
                else {
                    
                    print("Response Failed:\(response)")
                    failure(error!)
                }
                
            }
            if let data = data
            {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [] )
                    print("Data json:\(json)")
                    
                    success(json)
                    
                    
                } catch  {
                    print(error)
                }
                
            }
            
        }
        
        dataTask.resume()
        
        return ""
    }
    
}
