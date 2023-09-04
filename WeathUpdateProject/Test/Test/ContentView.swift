//
//  ContentView.swift
//  Test
//
//  Created by naeem alabboodi on 8/31/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var  weatherViewModel =   PittsburghWeatherViewModel()
    @State var seleectCIty = false
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                HomeView(showingSheet: $seleectCIty)
                    BottomSheet()
                 
                if seleectCIty {
                    ChoseCity(seleectCIty: $seleectCIty)
                        .environmentObject(weatherViewModel)
                       
                }
            
            }
     
        }
        .environmentObject(weatherViewModel)
    }
}

#Preview {
    ContentView()
}
