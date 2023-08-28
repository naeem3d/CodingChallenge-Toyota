//
//  PittsbrughDataWeather.swift
//  CodingChallenge-Toyota
//
//  Created by naeem alabboodi on 8/25/23.
//

import SwiftUI
import RiveRuntime

struct PittsbrughDataWeather: View {
    @State private var enteredCity: String = "London"
    @State private var selectedCity: String = "London"
    @State var riveAnimation : String = ""
    @ObservedObject var viewModel: PittsburghWeatherViewModel{
        didSet {
            riveAnimation =  updateRiveAnimation()
        }
    }
  @State  var currentDate = Date()
    let calendar = Calendar.current
    @State  var countid =  1
    // List of cities for Test in the same time your can wrtie city in the text feild
    let cities: [String] = ["London", "New York", "Paris", "Berlin", "Victoria","San Juan", "Pittsburgh","Nassau","San Antonio","Amman"]
    
    init() {
        viewModel = PittsburghWeatherViewModel()
    }
    var body: some View {
        ScrollView {
            ZStack {
                Color.cyan
                if riveAnimation == "new_file-30" {
                    RiveViewModel(fileName: riveAnimation).view()
                        .edgesIgnoringSafeArea(.all)
                }else {
                    RiveViewModel(fileName:"new_file-17").view()
                        .edgesIgnoringSafeArea(.all)
                }
                
                VStack(spacing: 20) {
                    Spacer()
                    // Picker for selecting city
                    Picker("Select a City", selection: $selectedCity) {
                        ForEach(cities, id: \.self) { city in
                            Text(city).tag(city)
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .stroke(lineWidth: 3)
                    }
                    .pickerStyle(MenuPickerStyle()) // You can choose other styles as well
                    .onChange(of: selectedCity) {
                        DispatchQueue.main.async {
                            riveAnimation = updateRiveAnimation()
                        }
                    }
                    TextField("Enter city", text: $selectedCity
                        .onChange {
                            viewModel.city = selectedCity
                            
                        })
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    VStack {
                        
                        if let weather = viewModel.pitsbrughDataWeather {
                            let Temperature =       (weather.main.temp - 273.15)
                            VStack {
                                Text("\(weather.name)")
                                   
                                HStack {
                                    Image(systemName: "thermometer.transmission")
                                       
                                    Text(" \(Temperature, specifier: "%.1f")°C")
                                      
                                }
                            }
                            .font(.system(size: 25))
                            .foregroundColor(.blue)
                            .bold()
                        }
                        
                    }
                    .cornerRadius(15)
                    
                    if let weather = viewModel.pitsbrughDataWeather {
                        
                        //                    Text("Weather in \(weather.name)")
                        
                        
                        
                        if let firstWeather = weather.weather.first {
                            
                            VStack {
                                
                                ZStack {
                                    HStack {
                                        WeatherIconView(condition: WeatherCondition(rawValue: firstWeather.main))
                                        Text(firstWeather.main)
                                            .font(.title2)
                                            .foregroundStyle(Color.blue)
                                    }
                                    
                                    
                                }
                                Text(firstWeather.description)
                                    .font(.title3)
                                    .foregroundStyle(Color.blue)
                            }
                            
                            
                        }
                        let Temperature =       (weather.main.temp - 273.15)
                        let FeelsLike =       ( weather.main.feelsLike - 273.15)
                     
                            HStack {
                                VStack{
                                    Text("Temp")
                                    Text(" \(Temperature, specifier: "%.1f")°C")
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
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 2)
                        }
                        
                    } else if let error = viewModel.errorMessage {
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
//                        Color.cyan
//                            .opacity(0.2)
                        VStack  {
                         
                            Text("5 Days Forcast")
                            let result = viewModel.theForcastFor5Days
                  
                            ForEach(result?.list.prefix(5) ?? []){item in
                               
                              
                                VStack {
                               Text("\(currentDate)")
                                    Text("Temp: \(item.main.temp, specifier: "%.1f")°C)")
                                        .padding(.leading)
                                    
                                    ForEach(item.weather) { newItem in
                                        VStack {
                                            Text("description: \(newItem.description.rawValue)")
    //                                        Text("\(newItem.main.rawValue)")
                                                .padding(.leading)
                                        }
                                        
                                    }
                                
                                }
                                
                            }
                            
                            
                        }
                        .multilineTextAlignment(.leading)
                       
                       
                          
                          
                        .onAppear {
                            print(viewModel.theForcastFor5Days ?? "")
                    }
                    }
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 2)
                    }
                    HStack {
                        Button("Fetch Weather for \(selectedCity)") {
                            viewModel.setCityAndFetchWeather(for: selectedCity) {
                                DispatchQueue.main.async {
                                    
                                    riveAnimation = updateRiveAnimation()
                                }
                                
                            }
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                    }
                }
                .padding()
                .onAppear() {
                    viewModel.fetchSchools() // Initial fetch when the view appears
                    
                }
                .onAppear {
                    print(riveAnimation)
                }
            }
        }
    }
    
    func nextDate(after date: Date) -> Date {
        let calendar = Calendar.current
        currentDate = calendar.date(byAdding: .day, value: 1, to: date) ?? date
        return currentDate
    }
    
 
    
    func updateRiveAnimation() -> String {
        if let firstWeather = viewModel.pitsbrughDataWeather?.weather.first {
            switch firstWeather.main {
            case "Clouds":
                riveAnimation = "new_file-17"
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
    PittsbrughDataWeather()
}


extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
