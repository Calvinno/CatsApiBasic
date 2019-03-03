//
//  ViewController.swift
//  CatsImage
//
//  Created by Calvin Cantin on 2019-02-26.
//  Copyright © 2019 Calvin Cantin. All rights reserved.
//

import UIKit

class CatsViewController: UIViewController {
    var imageQuery: [String: String] = ["limit": "1"]
    
    @IBOutlet weak var randomCatsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomCat()
    }
    
  @IBAction func randomCatButtonTapped(_ sender: UIButton) {
    randomCat()
}
func randomCat()
{
    CatsController.shared.fetchImageUrl(with: imageQuery) { (stringUrl) in
        if let stringUrl = stringUrl
        {
            let url = URL(string: stringUrl)!
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if let data = data, let image = UIImage(data: data)
                {
                    DispatchQueue.main.async {
                        self.randomCatsImageView.image = image
                    }
                }
            })
            task.resume()
        }
    }
}
}


