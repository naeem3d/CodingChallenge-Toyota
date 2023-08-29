//
//  StandurdView.swift
//  CodingChallenge-Toyota
//
//  Created by naeem alabboodi on 8/27/23.
//

import SwiftUI
import RiveRuntime

struct StandurdView: View {
    @State private var enteredCity: String = "London"
    @State private var selectedCity: String = "London"
    @State var riveAnimation : String = ""
    @StateObject var viewModel22 = PittsburghWeatherViewModel()
    @State var currentDate = Date()
    let cities: [String] = ["London", "New York", "Paris", "Berlin", "Victoria","San Juan", "Pittsburgh","Nassau","San Antonio"]
    
    var dateForecastPairs: [(Date, List)] { // Assuming ListType is the type of items inside your `list`
        let calendar = Calendar.current
        return Array(viewModel22.theForcastFor5Days?.list.prefix(5) ?? []).enumerated().map { (index, item) in
            let date = calendar.date(byAdding: .day, value: index, to: currentDate) ?? currentDate
            return (date, item)
        }
    }
    
    
    
    var body: some View {
      
           
        ZStack {
            if let firstWeather = viewModel22.pitsbrughDataWeather?.weather.first {
               
                if firstWeather.main == "Clear" {
                    RiveViewModel(fileName: "Clear_Weather31").view()
                        .scaleEffect(1.2)
                        .ignoresSafeArea()
                } else if firstWeather.main == "Clouds" {
                    RiveViewModel(fileName: "Cloudi_31").view()
                        .scaleEffect(1.2)
                        .ignoresSafeArea()
                }else if firstWeather.main == "Rain" {
                    RiveViewModel(fileName: "RainWeather31").view()
                        .scaleEffect(1.2)
                        .ignoresSafeArea()
                } else if firstWeather.main == "cloud.fog.circle.fill" {
                    RiveViewModel(fileName: "fog-31").view()
                        .scaleEffect(1.2)
                        .ignoresSafeArea()
                }else if firstWeather.main == "thenderstorm" {
                    RiveViewModel(fileName: "RainWeather31").view()
                        .scaleEffect(1.2)
                        .ignoresSafeArea()
                }
            }
           
            
            ScrollView {
                VStack(spacing: 20) {
                    
            
                    // Picker for selecting city
                    HStack {
                        Spacer()
                        Picker("Select a City", selection: $selectedCity) {
                            ForEach(cities, id: \.self) { city in
                                Text(city)
                                            .font(.system(size: 20))
                                      
                                   
                            }
                        }
                        .accentColor(Color.black)
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 200)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                       .fill(Color.cyan)
                                       .opacity(0.8)
                        )
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.purple, lineWidth: 2))
                        
                        .onChange(of: selectedCity) {
                            DispatchQueue.main.async {
                                riveAnimation = updateRiveAnimation()
                            }
                        }
                        
                        Spacer()
                        Button {
                            viewModel22.setCityAndFetchWeather(for: selectedCity) {
                                DispatchQueue.main.async {
                                    
                                    riveAnimation = updateRiveAnimation()
                                }
                                
                            }
                        } label: {
                            Text("Fetch Weather")
                                .padding(8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .frame(height: 50)
                                .multilineTextAlignment(.center)
                        }

                        
                       
                    }
                    
                    TextField("Enter city", text: $selectedCity
                        .onChange {
                            viewModel22.city = selectedCity
                            
                        })
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                                   .fill(Color.cyan)
                                   .opacity(0.3)
                    )
                    .opacity(0.9)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.purple, lineWidth: 2)
                    }
                    .foregroundColor(Color.black)
                    VStack {
                        
                        if let weather = viewModel22.pitsbrughDataWeather {
                            let Temperature =   (weather.main.temp - 273.15)
                            VStack {
                                Text("\(weather.name)")
                                
                                HStack {
                                    Image(systemName: "thermometer.transmission")
                                    
                                    Text(" \(Temperature, specifier: "%.1f")°C")
                                    
                                }
                            }
                            .font(.system(size: 40))
                            .foregroundColor(.primary)
                            .bold()
                            if let firstWeather = weather.weather.first {
                                
                                VStack {
                                    
                                    ZStack {
                                        HStack {
                                            WeatherIconView(condition: WeatherCondition(rawValue: firstWeather.main))
    //                                        Text(firstWeather.main)
    //                                            .font(.title2)
    //                                            .foregroundStyle(Color.blue)
                                            Text(firstWeather.description)
                                                .font(.title3)
                                                .foregroundStyle(Color.blue)
                                        }
                                        
                                        
                                    }
                                   
                                }
                                
                                
                            }
                        }
                            
                    }
                   
                    
                    
                    if let weather = viewModel22.pitsbrughDataWeather {
                       
                        let Temp = (weather.main.temp - 273.15)
                        let FeelsLike =       ( weather.main.feelsLike - 273.15)
                        
                        HStack {
                            VStack{
                                Text("Temp")
                                Text(" \(Temp, specifier: "%.1f")°C")
                            }
                            VStack{
                                Text("Feels L. ")
                                Text("\(FeelsLike, specifier: "%.1f")°C")
                            }
                            VStack{
                                Text("Wind.S.")
                                Text("\(weather.wind.speed, specifier: "%.2f") m/s")
                            }
                            VStack{
                                Text("Hum:")
                                Text(" \(weather.main.humidity)%")
                            }
                            VStack{
                                Text("Clo: ")
                                Text("\(weather.clouds.all)%")
                            }
                        }
                        
                        
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                       .fill(Color.cyan)
                                       .opacity(0.3)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 2)
                        }
                        
                    } else if let error = viewModel22.errorMessage {
                        Text("Error")
                            .font(.largeTitle)
                        
                        Text(error)
                            .font(.title2)
                            .foregroundColor(.red)
                    } else {
                        Text("Loading or no data")
                            .font(.title2)
                    }
                    ZStack {
                        VStack  {
                            
                            Text("5 Days Forcast")
                            
                            
                            ForEach(dateForecastPairs, id: \.1.id) { (date, item) in
                                ScrollView {
                                    HStack {
                                        Text("\(date.formatted(date: .numeric, time: .omitted))")
                                        Text(" \(item.main.temp, specifier: "%.1f")°C)")
                                            .padding(.leading)
                                        
                                        ForEach(Array(item.weather.enumerated()), id: \.offset) { index, newItem in
                                            Divider()
                                            HStack {
                                                if let condition = WeatherCondition2(rawValue: newItem.description.rawValue) {
                                                    Image(systemName: condition.imageName)
                                                        .scaleEffect(2)
                                                }
                                                Spacer()
                                                Text(" \(newItem.description.rawValue)")
                                                    .padding(.leading)
                                                    .multilineTextAlignment(.center)
                                                
                                            }
                                            Divider()
                                        }
                                    }
                                    .padding(8)
                                }
                                Divider()
                            }
                            
                            
                        }
                        .multilineTextAlignment(.leading)
                        .onAppear {
                            print(viewModel22.theForcastFor5Days ?? "")
                        }
                        
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                                   .fill(Color.cyan)
                                   .opacity(0.3)
                    )
                    .overlay {
                 
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 2)
                            
                       
                    }
                    
                   
                }
                .ignoresSafeArea()
                .padding()
                .onAppear() {
                    viewModel22.fetchSchools() // Initial fetch when the view appears
                    
                }
                .onAppear {
                    print(riveAnimation)
                }
            }
           
        }
        .onAppear {
            let firstWeather = viewModel22.pitsbrughDataWeather?.weather.first
            print("weather Condition is : \(String(describing: firstWeather))")
            
        }
    }
    func nextDate(after date: Date) -> Date {
        let calendar = Calendar.current
        currentDate = calendar.date(byAdding: .day, value: 1, to: date) ?? date
        return currentDate
    }
    
 
    
    func updateRiveAnimation() -> String {
        if let firstWeather = viewModel22.pitsbrughDataWeather?.weather.first {
            switch firstWeather.main {
            case "Clouds":
                riveAnimation = "new_file-20"
                return riveAnimation
                
            case "thunderstorm":
                        riveAnimation = "RainWeather31"
                        return riveAnimation
                
            case "Clear":
                riveAnimation = "new_file-16"
            default:
                riveAnimation = "new_file-16" // default or backup animation
                return riveAnimation
            }
        } else {
            riveAnimation = "new_file-16" // default or backup animation
            return riveAnimation
        }
        return riveAnimation
    }
}

#Preview {
    StandurdView()
}
