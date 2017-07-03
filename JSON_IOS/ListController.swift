//
//  ListController.swift
//  JSON_IOS
//
//  Created by Rohit Deshmukh on 6/16/17.
//  Copyright © 2017 San Jose State University. All rights reserved.
//

import Foundation
import UIKit

class ListController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var networkManager:NetworkManager? = nil
    
    var usersArray:Array<User> = []
    
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        networkManager = NetworkManager()
        
        activityIndicator.startAnimating()
        
//        networkManager?.getAllUsers(success: { array in
//            
//            self.usersArray = array as! Array<User>
//            
//            DispatchQueue.main.async { [unowned self] in
//               
//                self.activityIndicator.stopAnimating()
//                
//                self.activityIndicator.hidesWhenStopped = true
//                
//                self.usersTableView.reloadData()
//            }
//            
//        }, failure: { error in
//            
//            print("Error in getting data from Network Manager, Error \(error)")
//            self.activityIndicator.stopAnimating()
//            
//        })

        
        networkManager?.mockUsersData(success: { array in
            
            self.usersArray = array as! Array<User>
            
            DispatchQueue.main.async { [unowned self] in
                
                self.activityIndicator.stopAnimating()
                
                self.activityIndicator.hidesWhenStopped = true
                
                self.usersTableView.reloadData()
            }
            
        }, failure: { error in
            
            print("Error in getting data from Network Manager, Error \(error)")
            self.activityIndicator.stopAnimating()
            
        })

    }
    
    var arr = ["Cell 1"," Cell 2", " cell 3"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usersArray.count   // returns the count of collection
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //when user taps on the particular cell.
//    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! UserCell
        
        cell.usernameLabel.text = usersArray[indexPath.row].userFullName
        cell.emailLabel.text = usersArray[indexPath.row].email
        cell.ratingLabel.text = String(format:"Rating is %d",usersArray[indexPath.row].rating)
        
        return cell
        

    }


}
