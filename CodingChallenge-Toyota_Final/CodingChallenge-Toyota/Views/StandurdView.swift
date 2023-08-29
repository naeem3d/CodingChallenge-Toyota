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
    @StateObject var weatherViewModel = PittsburghWeatherViewModel()
    @State var currentDate = Date()
    let cities: [String] = ["London", "New York", "Paris", "Berlin", "Victoria","San Juan", "Pittsburgh","Nassau","San Antonio"]
    
    var dateForecastPairs: [(Date, List)] { // Assuming ListType is the type of items inside your `list`
        let calendar = Calendar.current
        return Array(weatherViewModel.theForcastFor5Days?.list.prefix(5) ?? []).enumerated().map { (index, item) in
            let date = calendar.date(byAdding: .day, value: index, to: currentDate) ?? currentDate
            return (date, item)
        }
    }
    
    
    
    var body: some View {
      
           
        ZStack {
            if let firstWeatherMain = weatherViewModel.pitsbrughDataWeather?.weather.first?.main,
                   let weatherCondition = WeatherCondition(rawValue: firstWeatherMain) {

                    switch weatherCondition {
                    case .clear:
                        RiveViewModel(fileName: weatherCondition.riveAnimationFileName).view()
                            .scaleEffect(1.2)
                            .ignoresSafeArea()
                    case .clouds:
                        RiveViewModel(fileName: weatherCondition.riveAnimationFileName).view()
                            .scaleEffect(1.2)
                            .ignoresSafeArea()
                    case .rain:
                        RiveViewModel(fileName: weatherCondition.riveAnimationFileName).view()
                            .scaleEffect(1.2)
                            .ignoresSafeArea()
                    case .fog:
                        RiveViewModel(fileName: weatherCondition.riveAnimationFileName).view()
                            .scaleEffect(1.2)
                            .ignoresSafeArea()
                    case .thunderstorm:
                        RiveViewModel(fileName: weatherCondition.riveAnimationFileName).view()
                            .scaleEffect(1.2)
                            .ignoresSafeArea()
                    
                    case .windy:
                        RiveViewModel(fileName: weatherCondition.riveAnimationFileName).view()
                            .scaleEffect(1.2)
                            .ignoresSafeArea()
                    case .snowy:
                        RiveViewModel(fileName: weatherCondition.riveAnimationFileName).view()
                            .scaleEffect(1.2)
                            .ignoresSafeArea()
                    case .sunny:
                        RiveViewModel(fileName: weatherCondition.riveAnimationFileName).view()
                            .scaleEffect(1.2)
                            .ignoresSafeArea()
                    case .smoke:
                        RiveViewModel(fileName: weatherCondition.riveAnimationFileName).view()
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
                            weatherViewModel.setCityAndFetchWeather(for: selectedCity) {
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
                    Text("Test add some view ")
                    TextField("Enter city", text: $selectedCity)
                        .onChange(of: selectedCity){
                            weatherViewModel.city = selectedCity
                            
                        }
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
                        
                        if let weather = weatherViewModel.pitsbrughDataWeather {
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
                   
                    
                    
                    if let weather = weatherViewModel.pitsbrughDataWeather {
                       
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
                        
                    } else if let error = weatherViewModel.errorMessage {
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
                            print(weatherViewModel.theForcastFor5Days ?? "")
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
                    weatherViewModel.fetchSchools() // Initial fetch when the view appears
                    
                }
                .onAppear {
                    print(riveAnimation)
                }
            }
           
        }
        .onAppear {
            let firstWeather = weatherViewModel.pitsbrughDataWeather?.weather.first
            print("weather Condition is : \(String(describing: firstWeather))")
            
        }
    }
    func nextDate(after date: Date) -> Date {
        let calendar = Calendar.current
        currentDate = calendar.date(byAdding: .day, value: 1, to: date) ?? date
        return currentDate
    }
    
 
    func updateRiveAnimation() -> String {
        if let firstWeatherMain = weatherViewModel.pitsbrughDataWeather?.weather.first?.main,
           let weatherCondition = WeatherCondition(rawValue: firstWeatherMain) {
            riveAnimation = weatherCondition.riveAnimationFileName
            return riveAnimation
        } else {
            riveAnimation = WeatherCondition.clear.riveAnimationFileName // default or backup animation
            return riveAnimation
        }
    }

}

#Preview {
    StandurdView()
}
