//
//  CatsController.swift
//  CatsImage
//
//  Created by Calvin Cantin on 2019-02-26.
//  Copyright © 2019 Calvin Cantin. All rights reserved.
//

import Foundation
import UIKit

struct CatsController
{
    
    static let shared = CatsController()
    let uplodedImageNumber:Int = 0
    
    func fetchCatsBreadAndId(completition: @escaping ([Breed]?) -> Void)
    {
        let url = URL(string: "https://api.thecatapi.com/v1/breeds")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("x-api-key: 3ceab02f-a986-4f3b-8e09-0bbe5c820fa7", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data, let breeds = try? jsonDecoder.decode([Breed].self, from: data)
            {
                completition(breeds)
            }
            else
            {
                completition(nil)
            }
        }
        task.resume()
    }
    func fetchImageUrl(with query: [String: String], completition: @escaping (String?) -> Void) {
        let baseUrl = URL(string: "https://api.thecatapi.com/v1/images/search")!
        let url = baseUrl.withQueries(query)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("x-api-key: 3ceab02f-a986-4f3b-8e09-0bbe5c820fa7", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let catImage = try? jsonDecoder.decode([CatImage].self, from: data)
            {
                
                completition(catImage[0].url)
            }
            else if let reaponse = response
            {
                print(response)
                completition(nil)
            }
        }
        task.resume()
    }
    func uploadCatImage(image: UIImage, completition: @escaping (UIAlertController) -> Void)
    {
        let url = URL(string: "https://api.thecatapi.com/v1/images/upload")!
        var request = URLRequest(url: url)
        let imageData = image.jpegData(compressionQuality: 1)
        let uploadedImage = UploadedCatImage(file: imageData!, sub_id: "1")
        let jsonEncodeer = JSONEncoder()
        guard let jsonData = try? jsonEncodeer.encode(uploadedImage) else {print("error"); return}
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("x-api-key: 3ceab02f-a986-4f3b-8e09-0bbe5c820fa7", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { (data, response, error) in
            if let data = data
            {
                
                let alertController = UIAlertController(title: "Upload Succeed", message: nil, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                completition(alertController)
            }
            else if let error = error
            {
                let alertController = UIAlertController(title: "Upload Fail", message: error.localizedDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                completition(alertController)
                
            }
        }
        task.resume()
    }
    func fetchUploadImage(with query: [String: String], completition: @escaping ([URL]?) -> Void)
    {
        var imagesUrls:[URL] = [URL]()
        let baseUrl = URL(string: "https://api.thecatapi.com/v1/images/upload")!
        let url = baseUrl.withQueries(query)!
        var request = URLRequest(url: url)
        request.addValue("x-api-key: 3ceab02f-a986-4f3b-8e09-0bbe5c820fa7", forHTTPHeaderField: "Authorization")
        print(request.url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let catsImages = try? jsonDecoder.decode([CatImage].self, from: data)
            {
                imagesUrls = catsImages.map {URL(string: $0.url)!}
                completition(imagesUrls)
            }
            else if let error = error
            {
                print(error)
                completition(nil)
            }
            else if let response = response
            {
                print(response.description)
                completition(nil)
            }
        }
        task.resume()
        
    }
    
}
