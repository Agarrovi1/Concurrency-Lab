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
    
    var country: Country?
    func loadData() {
        guard let country = country else {return}
        imageView.image = country.getFlagPicture()
        nameLabel.text = country.name
        capitalLabel.text = "Capital: \(country.capital)"
        populationLabel.text = "Pop: \(country.population)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
