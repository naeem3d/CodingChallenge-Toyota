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
        Image(systemName: imageName(for: condition ?? .unkown))
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(.blue)
    }
    func imageName(for condition: WeatherCondition) -> String {
        switch condition {
            
        case .sunny:
            return "sun.max.fill"
        case .cloudy:
            return "cloud.fill"
        case .rainy:
            return "cloud.rain.fill"
        case .windy:
            return "wind"
        case .snowy:
            return "cloud.snow.fill"
        case .unkown:
            return "questionmark.square.fill"
        case .fog:
            return "cloud.fog.fill"
        }
    }
}

#Preview {
    WeatherIconView(condition: .sunny)
}

enum WeatherCondition: String {
    case sunny = "Clear"
    case cloudy = "Clouds"
    case rainy = "Rain"
    case windy = "Windy"
    case snowy = "Snow"
    case fog = "Fog"
    case unkown = "questionmark.square.fill"
}
