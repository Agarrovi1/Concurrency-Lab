//
//  CountryDetailViewController.swift
//  ConcurrencyLab
//
//  Created by Angela Garrovillas on 9/3/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var exchangeRatesLabel: UILabel!
    
    var rates = [ExchangeRates]() {
        didSet {
            getCurrencyInUSD(rate: rates[0].rates)
        }
    }
    var country: Country? {
        didSet{
            loadRates()
        }
    }
    
    
    func loadData() {
        guard let country = country else {return}
        imageView.image = country.getFlagPicture()
        nameLabel.text = country.name
        capitalLabel.text = "Capital: \(country.capital)"
        populationLabel.text = "Pop: \(country.population)"
    }
    func loadImage() {
        imageView.image = country?.getFlagPicture()
    }
    func loadRates() {
        RatesAPIClient.manager.getRates { (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let ratesFromJSON):
                DispatchQueue.main.async {
                    self.rates = [ratesFromJSON]
                }
            }
        }
    }
    func getCurrencyInUSD(rate: ExchangeRates.Rates) {
        guard let country = country else {return}
        
        let mirror = Mirror(reflecting: rate)
        var usd = Double()
        var currentCurrency = Double()
        for child in mirror.children {
            if let key = child.label, key == "USD" {
                usd = child.value as? Double ?? 1
            }
            
            if let key = child.label, key == country.getCurrency() {
                currentCurrency = child.value as? Double ?? 1
            }
        }
        
        exchangeRatesLabel.text = "Currency In USD: \(usd / currentCurrency)"
            
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    

}
