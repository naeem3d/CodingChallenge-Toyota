//
//  PittsburghWeatherViewModel.swift
//  CodingChallenge-Toyota
//
//  Created by naeem alabboodi on 8/25/23.
//

import SwiftUI

// At this class i will fetch and manage data for my views



class PittsburghWeatherViewModel: ObservableObject {
    @Published var pitsbrughDataWeather: PittsburghWeather?
    @Published var theForcastFor5Days: The5DaysForCast?
    @Published var errorMessage: String?
    @Published var city = "London" // direct initialization
    private var apiServiceProt: APIServiceProtocol
    
    private var apiService = APIServces()
    
    init(apiService: APIServiceProtocol = APIServces()) {
           self.apiServiceProt = apiService
       }
    
    func setCityAndFetchWeather(for city: String, completion: @escaping () -> Void) {
            self.city = city
            fetchSchools()
        completion()
        }
    
    func fetchSchools() {
        Task {
            do {
                let fetchSchools = try await apiService.fetchWeatherDataForCity(city: city )
                DispatchQueue.main.async {
                    self.pitsbrughDataWeather = fetchSchools
                }
            } catch let error as APIServiceError {
                DispatchQueue.main.async {
                    switch error {
                        
                    case .Error400:
                        self.errorMessage = "Error 400 - Bad Request. You can get 400 error if either some mandatory parameters in the request are missing or some of request parameters have incorrect format or values out of allowed range. List of all parameters names that are missing or incorrect will be returned in `parameters`attribute of the `ErrorResponse` object."
                    case .Error401:
                        self.errorMessage = "Error 401 - Unauthorized. You can get 401 error if API token did not providen in the request or in case API token provided in the request does not grant access to this API. You must add API token with granted access to the product to the request before returning it."
                    case .Error404:
                        self.errorMessage = "Error 404 - Not Found. You can get 404 error if data with requested parameters (lat, lon, date etc) does not exist in service database. You must not retry the same request."
                    case .Error429:
                        self.errorMessage = "Error 429 - Too Many Requests. You can get 429 error if key quato of requests for provided API to this API was exceeded. You may retry request after some time or after extending your key quota."
                    case .Errors5xx:
                        self.errorMessage  = "Errors 5xx - Unexpected Error. You can get '5xx' error in case of other internal errors. Error Response code will be `5xx`. Please contact us and enclose an example of your API request that receives this error into your email to let us analyze it and find a solution for you promptly. You may retry the request which led to this error."
                    }
                }
            }
        }
        Task {
            apiService.fetchWeatherForecast(city: city) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.theForcastFor5Days = data
                        print(data)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        // Use your error handling logic here
                        self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
    
    
}
