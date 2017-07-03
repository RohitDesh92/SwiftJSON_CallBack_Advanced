//
//  ViewController.swift
//  JSON_IOS
//
//  Created by Rohit Deshmukh on 6/7/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func set(_ sender: Any) {
        
       
        
  
        
        
    }
   
    @IBAction func GetUsers(_ sender: Any) {
        
        guard let url = URL(string: "http://localhost:8080/Cooking_App_Server/webapi/users/") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if let response = response{
                print(response)
            }
            if let data = data{
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [] )
                    print(json)
                    
                    
                } catch  {
                    print(error)
                }
                
            }
            
            }.resume()
 
        
    }
    
    @IBOutlet weak var Get_Recordid: UITextField!
    @IBOutlet weak var GetRecord: UITextView!

    @IBAction func onGetTapped(_ sender: Any) { // Hit th URL and get the data from the server
      
        guard let url = URL(string: "http://localhost:8080/Cooking_App_Server/webapi/users/") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if let response = response{
              print(response)
            }
            if let data = data{
               
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [] )
                    print(json)
                    
                    
                } catch  {
                    print(error)
                }
            
            }
            
        }.resume()
        
    }
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               
        
        
        
        
        

    }

   

}

