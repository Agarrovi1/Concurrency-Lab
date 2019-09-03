//
//  CountryClient.swift
//  ConcurrencyLab
//
//  Created by Angela Garrovillas on 9/3/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
let countryURL = URL(string:"https://restcountries.eu/rest/v2/name/united")

struct CountryAPIClient {
    static let shared = CountryAPIClient()
    
    enum FetchCountryErrors: Error {
        case remoteResponseError
        case noDataError
        case badDecodeError
    }
    
    func getCountries(completionHandler: @escaping (Result<[Country],Error>) -> ()) {
        guard let countryURL = countryURL else {print("problem unwrapping url")
            return
        }
        URLSession.shared.dataTask(with: countryURL) { (data, response, error) in
            guard error == nil else {completionHandler(.failure(FetchCountryErrors.remoteResponseError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(FetchCountryErrors.noDataError))
                return
            }
            guard let countries = Country.getCountries(from: data) else {
                completionHandler(.failure(FetchCountryErrors.badDecodeError))
                return
            }
            completionHandler(.success(countries))
        }.resume()
    }
}
