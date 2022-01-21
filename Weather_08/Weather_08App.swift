//
//  Weather_08App.swift
//  Weather_08
//
//  Created by Ryo on 2021/12/23.
//

import SwiftUI

@main
struct Weather_08App: App {
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    @ObservedObject var weatherDateList = WeatherDate()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        weatherDateList.searchWeather(keyword: "keyword")
        return true
    }
   
}
