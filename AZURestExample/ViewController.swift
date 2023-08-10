//
//  ViewController.swift
//  AZURestExample
//
//  Created by Azzam Ubaidillah on 10/08/23.
//

import UIKit
import AZURest
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://dummyjson.com/products/1")
        let request = URLRequest(url: url!)
        
        let dataRequest = AZURest.runRequest(urlRequest: request) { error, json in
            if let error = error {
                print("Error: \(error)")
            } else if let json = json {
                print("Received JSON: \(json)")
            }
        }
        
        // You can also store the 'dataRequest' instance if you want to manage the request further, such as canceling it.
    }
}
