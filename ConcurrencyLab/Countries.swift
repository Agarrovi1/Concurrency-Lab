//
//  Countries.swift
//  ConcurrencyLab
//
//  Created by Angela Garrovillas on 9/3/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
struct Country: Codable {
    let name: String
    let capital: String
    let population: String
    let currencies: Currency
    
    static func getCountries(from data: Data) -> [Country] {
        do {
            let countries = try JSONDecoder().decode([Country].self, from: data)
            return countries
        } catch {
            print(error)
        }
        return [Country]()
    }
    
    struct Currency: Codable {
        var code: String
    }
}
