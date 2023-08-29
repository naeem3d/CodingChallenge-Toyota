//
//  CityModel.swift
//  CodingChallenge-Toyota
//
//  Created by naeem alabboodi on 8/25/23.
//

import Foundation

// MARK: - The5DaysForCast
struct The5DaysForCast: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City2
}

// MARK: - City
struct City2: Codable {
    let id: Int
    let name: String
    let coord: Coord2
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord2: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable ,Identifiable {
    let id = UUID()
    let dt: Int
    let main: MainClass
    let weather: [Discription]
    let clouds: Clouds2
    let wind: Wind2
    let visibility: Int
    let pop: Double
    let sys: Sys2
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - Clouds
struct Clouds2: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys2: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Discription: Codable, Identifiable {
    let id: Int
    let main: MainEnum
    let description: Description
    let icon: String
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
    case thunderstorm = "Thenderstorm"
    case smoke = "Smoke"
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case fog = "cloud.fog.circle.fill"
    case thunderstorm = "Thenderstorm"
    case smoke = "Smoke"
}

// MARK: - Wind
struct Wind2: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}


enum WeatherCondition2: String {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
    case smoke = "Smoke"
}
extension WeatherCondition2 {
    var imageName: String {
        switch self {
        case .smoke:
            return "smoke.fill"
        case .brokenClouds:
            return "smoke.fill"
        case .clearSky:
            return "sun.max"
        case .fewClouds:
            return "cloud.sun.circle.fill"
        case .lightRain:
            return "cloud.sun.rain.circle.fill"
        case .overcastClouds:
            return "cloud.fill"
        case .scatteredClouds:
            return "smoke.circle"
        }
    }
}


enum WeatherCondition: String {
    case clouds = "Clouds"
    case clear,sunny = "Clear"
    case rain = "Rain"
    case windy = "Windy"
    case snowy = "Snow"
    case smoke = "Smoke"
    case fog = "cloud.fog.circle.fill"
    case thunderstorm = "thunderstorm"  // Note: Possible typo here? "thunderstorm"?
    
    var riveAnimationFileName: String {
        switch self {
        case .clouds:
            return "Cloudi_31"
        case .thunderstorm:
            return "RainWeather31"
        case .clear:
            return "Clear_Weather31"
        case .fog:
            return "fog-31"
        case .rain:
            return "RainWeather31"
        case .smoke:
            return "fog-31"
       
        default:
            return "Clear_Weather31" // default or backup animation
        }
    }
}
