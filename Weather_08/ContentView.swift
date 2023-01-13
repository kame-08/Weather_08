//
//  ContentView.swift
//  Weather_08
//
//  Created by Ryo on 2021/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherDateList = WeatherDate()
    @State var key1 = ""
    @State var Key2 = ""
    
    var body: some View {
        //        ZStack{
        //            ProgressView("通信中...")
        //                .onAppear {
        //                    weatherDateList.searchWeather(keyword: aiu)
        //                }
        
        VStack {
            if let weather = weatherDateList.weatherList.first{
                if weather.main == "Thunderstorm"{
                    Image(systemName: "cloud.bolt.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }else if weather.main == "Drizzle"{
                    Image(systemName: "cloud.rain.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }else if weather.main == "Rain"{
                    Image(systemName: "cloud.rain.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }else if weather.main == "Snow"{
                    Image(systemName: "snowflake")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } else if weather.main == "Clear"{
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }else if weather.main == "Clouds"{
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }else {
                    Image(systemName: "moon.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
            }
            
            Text(weatherDateList.place)
                .font(.title)
                .onAppear(){
                    weatherDateList.searchWeather(keyword: key1)
                }
            List(weatherDateList.weatherList) {weather in
                 HStack{
                     Text(weather.dt)
                     Spacer()
                     if weather.main == "Thunderstorm"{
                         Image(systemName: "cloud.bolt.fill")
                             .symbolRenderingMode(.multicolor)
                     }else if weather.main == "Drizzle"{
                         Image(systemName: "cloud.rain.fill")
                     }else if weather.main == "Rain"{
                         Image(systemName: "cloud.rain.fill")
                     }else if weather.main == "Snow"{
                         Image(systemName: "snowflake")
                     } else if weather.main == "Clear"{
                         Image(systemName: "sun.max.fill")
                     }else if weather.main == "Clouds"{
                         Image(systemName: "cloud.fill")
                     }else {
                         Image(systemName: "moon.fill")
                     }
                     Spacer()
                     Text("\(Int(weather.tempMin))°")
                     Spacer()
                     Text("\(Int(weather.tempMax))°")
                 }
             }
             .refreshable{
                 weatherDateList.searchWeather(keyword: key1)
             }
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            weatherDateList.searchWeather(keyword: key1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                weatherDateList.searchWeather(keyword: key1)
            }
        }
        //        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
