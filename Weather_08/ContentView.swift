//
//  ContentView.swift
//  Weather_08
//
//  Created by Ryo on 2021/12/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherDateList = WeatherDate()
    
    
    @State var aiu = "aaaaa"
    @State var kakiku = "kkk"
    
    
    
    var body: some View {
        ZStack{
            ProgressView("通信中...")
                .onAppear {
                    weatherDateList.searchWeather(keyword: aiu)
                }
            
            
            
            VStack {
                if let weather = weatherDateList.weatherList.first{
                    if weather.main == "Thunderstorm"{
                        Image(systemName: "cloud.bolt.fill")
                            .resizable()
                            .scaledToFit()
                        
                            .frame(width: 200, height: 200)
                        
                        
                    }else if weather.main == "Drizzle"{
                        Image(systemName: "cloud.rain.fill")
                            .resizable()
                            .scaledToFit()
                        
                            .frame(width: 200, height: 200)
                        // .symbolRenderingMode(.multicolor)
                    }else if weather.main == "Rain"{
                        Image(systemName: "cloud.rain.fill")
                            .resizable()
                            .scaledToFit()
                        
                            .frame(width: 200, height: 200)
                        //  .symbolRenderingMode(.multicolor)
                    }else if weather.main == "Snow"{
                        Image(systemName: "snowflake")
                            .resizable()
                            .scaledToFit()
                        
                            .frame(width: 200, height: 200)
                        //  .symbolRenderingMode(.multicolor)
                    } else if weather.main == "Clear"{
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .scaledToFit()
                        
                            .frame(width: 200, height: 200)
                        //  .symbolRenderingMode(.multicolor)
                    }else if weather.main == "Clouds"{
                        Image(systemName: "cloud.fill")
                            .resizable()
                            .scaledToFit()
                        
                            .frame(width: 200, height: 200)
                        //  .symbolRenderingMode(.multicolor)
                    }else {
                        Image(systemName: "moon.fill")
                            .resizable()
                            .scaledToFit()
                        
                            .frame(width: 200, height: 200)
                        
                        //  .symbolRenderingMode(.multicolor)
                    }
                    
                    
                }
                
                Text(weatherDateList.place)
                    .font(.title)
                
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
                         Text("\(Int(weather.temp))°")
                         
                     }
                 }
                
                 .refreshable{
                     weatherDateList.searchWeather(keyword: aiu)
                 }
                
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
