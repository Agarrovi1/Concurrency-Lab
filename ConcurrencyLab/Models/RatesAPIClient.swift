//
//  File.swift
//  ConcurrencyLab
//
//  Created by Angela Garrovillas on 9/5/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import Foundation
class RatesAPIClient {
    private init() {}
    static let manager = RatesAPIClient()
    
    enum FetchRatesErrors: Error {
        case remoteResponseError
        case noDataError
        case badDecodeError
    }
    
    func getRates(completionHandler: @escaping (Result<ExchangeRates,Error>) -> ()) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=a17aef5ece92cf36d9c5963f7f4babf1&format=1") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {completionHandler(.failure(FetchRatesErrors.remoteResponseError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(FetchRatesErrors.noDataError))
                return
            }
            guard let rates = ExchangeRates.getExchangeRates(from: data) else {
                completionHandler(.failure(FetchRatesErrors.badDecodeError))
                return
            }
            completionHandler(.success(rates))
        }.resume()
    }
    
}
