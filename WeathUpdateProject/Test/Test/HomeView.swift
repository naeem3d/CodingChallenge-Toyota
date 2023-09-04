//
//  HomeView.swift
//  Test
//
//  Created by naeem alabboodi on 9/1/23.
//

import SwiftUI
import RiveRuntime

struct HomeView: View {
    @EnvironmentObject var weatherViewModel:  PittsburghWeatherViewModel
    @State var currentDate = Date()
    @Binding  var showingSheet :Bool
    @State var vvv = BottomSheet()
    var vvvv = BottomSheet()
    
    
    var body: some View {
       
        ZStack {
         
            VStack {
                
                HStack{
                    VStack {
                        Text(weatherViewModel.pitsbrughDataWeather?.name ?? "")
                            .font(.system(size: 40))
                        Text(currentDate.formatted(date: .abbreviated, time: .shortened))
                    }
                    Spacer()
                  
                    HStack {
                        Button(action: {
                            weatherViewModel.setCityAndFetchWeather(for: "pittsburgh", completion: {})
                            weatherViewModel.fetchWeatherData()
//                            weatherViewModel.fetchCities()
                        
                        }, label: {
                            Image(systemName: "goforward")
                           
                        })
                        Button(action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation {
                                    showingSheet.toggle()
                                   
                                }
                               }
                            
                        }, label: {
                            Image(systemName: "magnifyingglass")
                        })
                    }
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    
                }
                .padding(.horizontal)
                VStack {
                    HStack {
                        
                        let weatherDescription = weatherViewModel.pitsbrughDataWeather?.weather.first?.description ?? ""
                     
                        let weatherType = WeatherAnimation(rawValue: weatherDescription)

                        if weatherDescription == "scattered clouds"{
                            RiveViewModel(fileName: "scatteredClouds2").view()
                                .frame(width: 100, height: 100)
                        } else if weatherDescription == "broken clouds" {
                            RiveViewModel(fileName: "scatteredClouds").view()
                                .frame(width: 100, height: 100)
                        } else if weatherDescription == "clear sky" {
                            RiveViewModel(fileName: "SunyCLear").view()
                                .frame(width: 100, height: 100)
                        } else if weatherDescription == "few clouds" {
                            RiveViewModel(fileName: "ScatteredCloudsOnly").view()
                                .frame(width: 100, height: 100)
                        } else {
                            RiveViewModel(fileName: "Cloudy").view()
                                .frame(width: 100, height: 100)
                                .onAppear {
                                    print("Weather Description from API: \(weatherDescription)")
                                }
                        }
                    
                        
                        let temp = (weatherViewModel.pitsbrughDataWeather?.main.temp ?? 100.0) - 273.15
                            Text(" \(temp, specifier: "%.1f")°C")
                            .font(.system(size: 60))
                    }
                    
                    Text(weatherViewModel.pitsbrughDataWeather?.weather.first?.description ?? "")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        
                 
                }
                .onAppear {
                    print("weatherDescription = \(weatherViewModel.pitsbrughDataWeather?.weather.first?.description ?? "")")
                }
                Spacer()
            }
            .onAppear {
                weatherViewModel.fetchWeatherData()
                
            }
            
        .background(.cyan)
            
          
        }

    }
}

#Preview {
    HomeView(showingSheet: .constant(false))
        .environmentObject(PittsburghWeatherViewModel())
}

enum WeatherAnimation: String {
    case clearSky = "clear sky"
    case scatteredClouds1 = " scattered clouds"
    case overcastClouds = "overcast clouds"
    case clear = "clear"
    case fewClouds = "few clouds"

    var animationName: String {
        switch self {
        case .clearSky:
            return "Cloudy"
        case .scatteredClouds1:
            return "ScatteredCloudsOnly"
        case .overcastClouds:
            return "overCast"

        case .clear:
            return "sunShine"
        case .fewClouds:
            return "Cloudy"
        }
    }
}
