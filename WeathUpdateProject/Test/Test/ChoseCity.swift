//
//  ChoseCity.swift
//  Test
//
//  Created by naeem alabboodi on 9/1/23.
//

import SwiftUI

struct ChoseCity: View {
    @EnvironmentObject var weatherViewModel: PittsburghWeatherViewModel
    @StateObject var result = CityViewModel()
    @State var text = ""
    @Binding var seleectCIty: Bool
    var body: some View {
        VStack (alignment:.leading){
            TextField("enter City", text: $text)
                .onChange(of: text) { newValue in
                        result.updateSearch(with: newValue)
                    }
                .foregroundColor(.blue)
                .onSubmit {
                    weatherViewModel.city = text
                    weatherViewModel.fetchWeatherData()
                    seleectCIty.toggle()
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.blue, lineWidth: 2)
                }
                .padding()
            Button {
                weatherViewModel.city = text
                weatherViewModel.fetchWeatherData()
                seleectCIty.toggle()
            } label: {
                Text("fetch Wether")
            }
            .buttonStyle(.borderedProminent)
            .padding()
            List {
                ForEach(result.filteredCities, id: \.self) { city in
                    Text(city.name)
                        .onTapGesture {
                            text = city.name
                        }
                        .onAppear {
                            if result.filteredCities.last == city && text.isEmpty {
                                result.loadMore()
                            }
                        }
                }
            }
            .searchable(text: $result.searchText, prompt: "Search Cities")
            .onChange(of: result.searchText) { newValue in
                result.searchCities()
            }
        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
    ChoseCity(  seleectCIty: .constant(false) )
        .environmentObject(PittsburghWeatherViewModel())
        .frame(width: 300,height: 700)
        .background(Color.mint)
        .cornerRadius(15)
}

