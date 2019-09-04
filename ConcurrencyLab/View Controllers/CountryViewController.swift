//
//  ViewController.swift
//  ConcurrencyLab
//
//  Created by Angela Garrovillas on 9/3/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    @IBOutlet weak var countryTableView: UITableView!
    var countries = [Country]() {
        didSet {
            DispatchQueue.main.async {
                self.countryTableView.reloadData()
            }
        }
    }
    
    func loadData() {
        CountryAPIClient.shared.getCountries { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let countriesFromURL):
                self.countries = countriesFromURL
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTableView.dataSource = self
        countryTableView.delegate = self
        loadData()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CountryDetailViewController, let indexPath = countryTableView.indexPathForSelectedRow else {return}
        destination.country = countries[indexPath.row]
    }
}

extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = countryTableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryTableViewCell else {return UITableViewCell()}
        let country = countries[indexPath.row]
        cell.flagImageView.image = country.getFlagPicture()
        cell.nameLabel.text = country.name
        cell.capitalLabel.text = "Capital: \(country.capital)"
        cell.populationLabel.text = "Pop: \(country.population)"
        return cell
    }
}

extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
}
