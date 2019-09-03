//
//  ConcurrencyLabTests.swift
//  ConcurrencyLabTests
//
//  Created by Angela Garrovillas on 9/3/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import XCTest
@testable import ConcurrencyLab

class ConcurrencyLabTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testCountriesInArray() {
        var countries = [Country]() {
            didSet {
                XCTAssertTrue(countries.count > 0, "expected countries but got \(countries.count)")
            }
        }
        CountryAPIClient.shared.getCountries { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let countriesFromURL):
                countries = countriesFromURL
            }
        }
    }

}
