//
//  TestApp.swift
//  Test
//
//  Created by naeem alabboodi on 8/31/23.
//

import SwiftUI

@main
struct TestApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(PittsburghWeatherViewModel())
        }
    }
}
