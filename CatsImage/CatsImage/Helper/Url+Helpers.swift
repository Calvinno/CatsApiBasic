//
//  Url+Helpers.swift
//  CatsImage
//
//  Created by Calvin Cantin on 2019-02-26.
//  Copyright © 2019 Calvin Cantin. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
