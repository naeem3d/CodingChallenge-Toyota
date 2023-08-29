//
//  MockAPIService.swift
//  CodingChallenge-Toyota
//
//  Created by naeem alabboodi on 8/27/23.
//

import Foundation


class MockAPIService: APIServiceProtocol {
    func fetchSchools(city: String) async throws -> PittsburghWeather {
        guard let url = Bundle.main.url(forResource: "MockData1", withExtension: "json") else { throw APIServiceError.Error429}
           

            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PittsburghWeather.self, from: data)
                return jsonData
            } catch {
                print("Error loading mock data: \(error)")
                if error is DecodingError {
                    throw APIServiceError.Error400
                } else {
                    throw APIServiceError.Error401
                }
            }
    }
    
    func fetchWeatherForecast(city: String, completion: @escaping (Result<The5DaysForCast, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "MockData2", withExtension: "json") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -2, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(The5DaysForCast.self, from: data)
                print(weatherData)
                completion(.success(weatherData))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }
}

