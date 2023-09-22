//
//  BaseAPI.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation

class BaseAPI {
    
    func urlRequest(withPath path: String, method: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: API.baseURL)
        request.httpMethod = method.rawValue
        return request
    }

    func urlRequest(withPath path: String, queryItems: [URLQueryItem], method: HTTPMethod) -> URLRequest {
        var components = API.baseURLComponents
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return urlRequest(withPath: path, method: method)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
