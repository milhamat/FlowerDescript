//
//  ViewController.swift
//  FlowerDescript
//
//  Created by Muhammad Ilham Ashiddiq Tresnawan on 13/02/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    let wikipediaURL = "https://en.wikipedia.org/w/api.php"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestInfo(flowerName: "Barberton Daisy")
    }

    func requestInfo(flowerName: String){
        
        let parameters : [String:String] = [
          "format" : "json",
          "action" : "query",
          "prop" : "extracts|pageimages",
          "exintro" : "",
          "explaintext" : "",
          "titles" : flowerName,
          "indexpageids" : "",
          "redirects" : "1",
            "pithumbsize" : "500"
          ]
        
        Alamofire.request(wikipediaURL, method: .get, parameters: parameters).responseJSON {
            (response) in
            if response.result.isSuccess {
                print("got the wikipedia info.")
                print(response)
                
                let flowerJSON: JSON  = JSON(response.result.value!)
                
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                
                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                
                let flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                
                self.textView.text = flowerDescription
                self.imageView.sd_setImage(with: URL(string: flowerImageURL))
                
                print("Description: \(flowerDescription)")
            }
        }
    }

}

