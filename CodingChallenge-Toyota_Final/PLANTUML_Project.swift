//
//  PLANTUML_Project.swift
//  CodingChallenge-Toyota
//
//  Created by naeem alabboodi on 8/29/23.
//

import Foundation
/*
 @startuml

 interface APIServiceProtocol {
     + fetchSchools(city: String): async throws PittsburghWeather
     + fetchWeatherForecast(city: String, completion: (Result<The5DaysForCast, Error>) -> Void): void
 }

 class APIServces {
     + fetchSchools(city: String): async throws PittsburghWeather
     + fetchWeatherForecast(city: String, completion: (Result<The5DaysForCast, Error>) -> Void): void
 }

 enum WeatherCondition {
     sunny, clouds, rain, windy, snowy, fog, thunderstorm, clear, smoke
     riveAnimationFileName()
 }

 enum APIServiceError {
     Error400, Error401, Error404, Error429, Errors5xx
 }

 class PittsburghWeatherViewModel {
     - pitsbrughDataWeather: PittsburghWeather?
     - theForcastFor5Days: The5DaysForCast?
     - errorMessage: String?
     - city: String
     - apiServiceProt: APIServiceProtocol
     - apiService: APIServces
     + setCityAndFetchWeather(for city: String, completion: () -> Void): void
     + fetchSchools(): void
 }

 class WeatherIconView {
     - condition: WeatherCondition?
     + imageName(for condition: WeatherCondition): String
 }

 class StandurdView {
     - enteredCity: String
     - selectedCity: String
     - riveAnimation: String
     - weatherViewModel: PittsburghWeatherViewModel
     - currentDate: Date
     - cities: String[]
     + dateForecastPairs: (Date, List)[]
     + nextDate(after date: Date): Date
     + updateRiveAnimation(): String
 }

 class RiveViewModel {
     - animationName: String
     + init(fileName: String)
     + view(): RiveView
 }

 class MockAPIService {
     + fetchWeatherDataForCity(city: String): async throws PittsburghWeather
     + fetchWeatherForecast(city: String, completion: (Result<The5DaysForCast, Error>) -> Void): void
 }
 
 
 
 StandurdView --> PittsburghWeatherViewModel
 StandurdView --> WeatherIconView
 RiveViewModel ..> StandurdView
 WeatherCondition <|.. WeatherIconView
 PittsburghWeatherViewModel o--> APIServiceProtocol
 PittsburghWeatherViewModel ..> WeatherCondition
 MockAPIService <|.. PittsburghWeatherViewModel
 APIServiceProtocol <|.. APIServces
 APIServiceProtocol <|.. MockAPIService
 @enduml

 */
