//
//  ContentView.swift
//  Weather_08
//
//  Created by Ryo on 2021/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherDateList = WeatherDate()
    
    //未実装パーツ
    @State var hoge = "hoge"
    //未実装パーツ
    @State var fuga = "fuga"
    
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
                    // .symbolRenderingMode(.multicolor)
                }else if weather.main == "Rain"{
                    Image(systemName: "cloud.rain.fill")
                        .resizable()
                        .scaledToFit()
                    
                        .frame(width: 150, height: 150)
                    //  .symbolRenderingMode(.multicolor)
                }else if weather.main == "Snow"{
                    Image(systemName: "snowflake")
                        .resizable()
                        .scaledToFit()
                    
                        .frame(width: 150, height: 150)
                    //  .symbolRenderingMode(.multicolor)
                } else if weather.main == "Clear"{
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .scaledToFit()
                    
                        .frame(width: 150, height: 150)
                    //  .symbolRenderingMode(.multicolor)
                }else if weather.main == "Clouds"{
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .scaledToFit()
                    
                        .frame(width: 150, height: 150)
                    //  .symbolRenderingMode(.multicolor)
                }else {
                    Image(systemName: "moon.fill")
                        .resizable()
                        .scaledToFit()
                    
                        .frame(width: 150, height: 150)
                    
                    //  .symbolRenderingMode(.multicolor)
                }
                
            }
            
            
            Text(weatherDateList.place)
                .font(.title)
                .onAppear(){
                    weatherDateList.searchWeather(keyword: hoge)
                }
            List(weatherDateList.weatherList) {weather in
                 
                 HStack{
                     
                     Text(weather.dt)
                     Spacer()
                     // Text(weather.main)
                     if weather.main == "Thunderstorm"{
                         Image(systemName: "cloud.bolt.fill")
                         
                             .symbolRenderingMode(.multicolor)
                     }else if weather.main == "Drizzle"{
                         Image(systemName: "cloud.rain.fill")
                         
                         // .symbolRenderingMode(.multicolor)
                     }else if weather.main == "Rain"{
                         Image(systemName: "cloud.rain.fill")
                         
                         //  .symbolRenderingMode(.multicolor)
                     }else if weather.main == "Snow"{
                         Image(systemName: "snowflake")
                         //  .symbolRenderingMode(.multicolor)
                     } else if weather.main == "Clear"{
                         Image(systemName: "sun.max.fill")
                         //  .symbolRenderingMode(.multicolor)
                     }else if weather.main == "Clouds"{
                         Image(systemName: "cloud.fill")
                         //  .symbolRenderingMode(.multicolor)
                     }else {
                         Image(systemName: "moon.fill")
                         //  .symbolRenderingMode(.multicolor)
                     }
                     Spacer()
                     Text("\(Int(weather.tempMin))°")
                     Spacer()
                     Text("\(Int(weather.tempMax))°")
                     
                 }
             }
             .refreshable{
                 weatherDateList.searchWeather(keyword: hoge)
             }
            
        }.onAppear {
            weatherDateList.searchWeather(keyword: hoge)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                weatherDateList.searchWeather(keyword: hoge)
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
