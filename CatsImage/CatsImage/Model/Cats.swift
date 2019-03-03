//
//  Cats.swift
//  CatsImage
//
//  Created by Calvin Cantin on 2019-02-26.
//  Copyright © 2019 Calvin Cantin. All rights reserved.
//

import Foundation

struct Breed: Codable
{
    var name: String
    var id: String
    
    enum CodingKeys: String, CodingKey
    {
        case name
        case id
    }
    
    init(from decoder:Decoder) throws
    {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.id = try valueContainer.decode(String.self, forKey: CodingKeys.id)
    }
}

struct CatImage: Codable
{
    var id: String
    var url: String
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case url
    }
    
    init(from decoder:Decoder) throws
    {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try valueContainer.decode(String.self, forKey: CodingKeys.id)
        print(self.id)
        self.url = try  valueContainer.decode(String.self, forKey: CodingKeys.url)
        print(self.url)
    }
}

struct UploadedCatImage: Codable
{
    var file: Data
    var sub_id: String
}
