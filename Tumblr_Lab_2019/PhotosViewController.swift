//
//  PhotosViewController.swift
//  Tumblr_Lab_2019
//
//  Created by Daniella Montinola on 10/19/19.
//  Copyright © 2019 Daniella Montinola. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    // MARK: - Properties
    
    // store the data returned from the network request
    var posts: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrievePosts()
    }
    
    
    // MARK: - Private Functions

    private func retrievePosts() {
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                // get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                
                // stores the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
            }
        }
        task.resume()
    }
}
