//
//  AppConstants.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation

enum API {
    private static let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
    static let baseURLComponents = URLComponents(string: baseURLString)!
    static let baseURL = URL(string: baseURLString)!
}
