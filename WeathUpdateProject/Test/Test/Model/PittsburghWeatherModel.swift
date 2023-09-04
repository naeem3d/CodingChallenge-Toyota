//
//  PittsburghWeatherModel.swift
//  CodingChallenge-Toyota
//
//  Created by naeem alabboodi on 8/25/23.
//

import Foundation
/*
 This URL will return the current weather for Pittsburgh in JSON format:
 http://api.openweathermap.org/data/2.5/weather?q=Pittsburgh,US&appid=7f34334342bc1e9948e1cb2b2992d9b6

 */
/*
 Key:7f34334342bc1e9948e1cb2b2992d9b6
 Name: PittsburghKEy
 */


// MARK: - PittsburghWeather
struct PittsburghWeather: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}
