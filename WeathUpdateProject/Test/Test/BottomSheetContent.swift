//
//  BottomSheetContent.swift
//  Test
//
//  Created by naeem alabboodi on 9/1/23.
//

import SwiftUI

struct BottomSheetContent: View {
    @EnvironmentObject var weatherViewModel: PittsburghWeatherViewModel
    @State var currentDate = Date()
    @State var currentWeather: WeatherDescription = .cloudy
   var dataForcastCity: [(Date, NewList)] { // Assuming ListType is the type of items inside your `list`
        let calendar = Calendar.current
        return Array(weatherViewModel.theForcastFor5Days?.list.prefix(5) ?? []).enumerated().map { (index, item) in
            let date = calendar.date(byAdding: .day, value: index, to: currentDate) ?? currentDate
            return (date, item)
        }
    }
    
    var body: some View {
        VStack (alignment: .leading){
            
            ForEach(dataForcastCity, id: \.1.id) { (date, item) in
                ForEach(Array(item.weather.enumerated()), id: \.offset) { index, newItem in
                    VStack {
                        if let weatherDesc = WeatherDescription(rawDescription: newItem.description.rawValue) {
                            
                            HStack {
                                Image(systemName: weatherDesc.imageName)
                                
                                    .symbolRenderingMode(.multicolor)
                                Text("\(date.displayFormat)")
                                
                                Text(" \(item.main.temp, specifier: "%.1f")°C")
                                
                                Text(" \(newItem.description.rawValue)")
                                
                                
                                
                            }
                            .font(.system(size: 20))
                            .onAppear {
                                
                            }
                            .padding()
                        }
                    }
                    .onAppear {
                        print("Thsi is value \(newItem.description.rawValue)")
                    }
                }
                
            }
        }
        .multilineTextAlignment(.leading)
        .onAppear {
            weatherViewModel.fetchWeatherData()
            
        }
    }
}

#Preview {
    BottomSheetContent()
               .environmentObject(PittsburghWeatherViewModel())
}


extension Date {
    var displayFormat: String {
        self.formatted(.dateTime.month().day())
    }
}
extension WeatherDescription {
    init?(rawDescription: String) {
        guard let match = WeatherDescription(rawValue: rawDescription) else {
            return nil
        }
        self = match
    }
}
