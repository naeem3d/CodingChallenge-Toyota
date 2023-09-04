//
//  CityViewModel.swift
//  Test
//
//  Created by naeem alabboodi on 9/2/23.
//

import Foundation

class CityViewModel: ObservableObject {
    @Published var cities: [CountriesList] = []
    @Published var currentPage: Int = 0
    @Published var searchText: String = ""
    @Published var allCities: [CountriesList] = [] // Stores all the cities
    @Published var filteredCities: [CountriesList] = [] // This will store either full list or filtered list
    private let pageSize = 50
    private var debounceTimer: Timer?

      
    
    init() {
        self.allCities = fetchCitiesList()
        loadMore()
    }
    
    func updateSearch(with newText: String) {
        debounceTimer?.invalidate()
        
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
            self?.searchText = newText
            self?.searchCities()
        }
    }
    
    func searchCities() {
        if searchText.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = allCities.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    func loadMore() {
        let start = currentPage * pageSize
        let end = start + pageSize
        let newCities = Array(allCities[start..<min(end, allCities.count)])
        cities.append(contentsOf: newCities)
        filteredCities = cities
        currentPage += 1
    }
    
    func fetchCitiesList() -> [CountriesList] {
        if let fileURL = Bundle.main.url(forResource: "Cities222", withExtension: "json"),
           let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([CountriesList].self, from: data) {
                print("this is is isisisisiisisisiisisisisisiisiisisis \(decodedData.count)")
                return decodedData
            }
        }
        return []
    }

}


enum WeatherDescription : String {
    
    
    case sunShine = ""
    case clear = "clear sky"
    case cloudy
    case partlyCloudy
    case overCast
    case Raining
    case snowy
    case foggy
    case thunderLighting
    case windy
    case hot
    case warm
    case cold
    case freezing
    case sleeting
    case storm
    case hailing
    case overcastClouds = "overcast clouds"
    case fewClouds = "few clouds"
    case brokenClouds = "broken clouds"
    case scatterdClouds = "scattered clouds"
    case lightrain = "light rain"
    
    var imageName: String {
        switch self {
        case .lightrain:
            return "cloud.sun.rain.fill"
        case .sunShine:
            return "sun.horizon.fill"
        case .clear:
            return "sun.max.fill"
        case .cloudy:
            return "icloud.fill"
        case .partlyCloudy:
            return "cloud.sun.fill"
        case .overCast:
            return "overCast"
        case .Raining:
            return "cloud.bolt.rain.fill"
        case .snowy:
            return "snowy"
        case .foggy:
            return "foggy"
        case .thunderLighting:
            return "thunder Lighting"
        case .windy:
            return "wind.snow.circle.fill"
        case .hot:
            return "thermometer.sun.fill"
        case .warm:
            return "thermometer.sun.fill"
        case .cold:
            return "cold"
        case .freezing:
            return "freezing"
        case .sleeting:
            return "sleeting"
        case .storm:
            return "sstorm"
        case .hailing:
            return "cloud.hail"
        case .overcastClouds:
            return "smoke"
        case .fewClouds:
            return "cloud.sun.fill"
        case .brokenClouds:
            return "icloud.circle.fill"
        case .scatterdClouds:
            return "icloud.fill"
       
           
        }
    }
}
