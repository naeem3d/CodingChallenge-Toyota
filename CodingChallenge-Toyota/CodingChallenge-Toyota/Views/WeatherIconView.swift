//
//  WeatherIconView.swift
//  CodingChallenge-Toyota
//
//  Created by naeem alabboodi on 8/25/23.
//

import SwiftUI

struct WeatherIconView: View {
    var condition: WeatherCondition?
    var body: some View {
        Image(systemName: imageName(for: condition ?? .clear))
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(.blue)
        
    }
    func imageName(for condition: WeatherCondition) -> String {
        switch condition {
        case .sunny:
            return "sun.max.fill"
        case .clouds:
            return "cloud.fill"
        case .rain:
            return "cloud.rain.fill"
        case .windy:
            return "wind"
        case .snowy:
            return "cloud.snow.fill"
        case .fog:
            return "cloud.fog.fill"
        case .thunderstorm:
            return "cloud.bolt.rain.fill"
        case .clear:
            return "sun.max.fill"
        case .smoke:
            return "smoke"
        }
    }
}

#Preview {
    WeatherIconView(condition: .sunny)
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
