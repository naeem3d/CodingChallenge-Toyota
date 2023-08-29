//
//  CodingChallenge_ToyotaTests.swift
//  CodingChallenge-ToyotaTests
//
//  Created by naeem alabboodi on 8/27/23.
//

import XCTest
@testable import CodingChallenge_Toyota

final class CodingChallenge_ToyotaTests: XCTestCase {

    var sut: PittsburghWeatherViewModel!
    
    override func setUp() {
           super.setUp()
           sut = PittsburghWeatherViewModel(apiService: MockAPIService())
       }
    override func tearDown() {
            sut = nil
            super.tearDown()
        }
        

    func testFetchingSchools() {
            // This is asynchronous, so you'd ideally use XCTestExpectations
            // to wait for the async task to complete.
            let expectation = self.expectation(description: "Fetching Schools")
            
            sut.fetchSchools()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                XCTAssertNotNil(self.sut.pitsbrughDataWeather)
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 5, handler: nil)
        }
        
        func testCitySettingAndFetching() {
            let expectation = self.expectation(description: "Setting city and fetching")
            
            sut.setCityAndFetchWeather(for: "pittsburgh") {
                XCTAssertEqual(self.sut.city, "pittsburgh")
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 5, handler: nil)
        }
        

}
