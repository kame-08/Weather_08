//
//  WeatherDate.swift
//  Weather_08
//
//  Created by Ryo on 2021/12/23.
//

import Foundation
import UIKit
import SwiftUI
import CoreLocation




struct WeatherItem: Identifiable {
    let id = UUID()
    let num :Int
    let dt: String
    var main: String
    let tempDay : Double
    let tempMin : Double
    let tempMax : Double
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherData = try? newJSONDecoder().decode(WeatherData.self, from: jsonData)



// MARK: - WeatherData
struct WeatherJson: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case daily
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop, uvi: Double
    let rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}



private func getLocation(from location: CLLocation, completion: @escaping (_ placemark: CLPlacemark) -> Void) {
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
        guard let placemark = placemarks?.first, error == nil else { return }
        completion(placemark)
    }
}



//検索用クラス
class WeatherDate: ObservableObject{

 
    var place = ""
    //Weatherのリスト
    @Published var weatherList: [WeatherItem] = []
    
    
    func searchWeather(keyword: String) {
        
        
        print(keyword)
        
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("return1")
            return
        }
        
        //リクエストURLの組み立て
        guard let req_url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=35.698785&lon=139.696548&exclude=current,minutely,hourly,alerts&units=metric&appid=8defd96e2f076346d90939073960c0d0&lang=ja") else {
            print("return2")
            return
        }
        
//        print("リクエストURL")
//        print(req_url)
        
        // リクエストに必要な情報を生成
        let req = URLRequest(url: req_url)
        // データ転送を管理するためのセッションを生成
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        // リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: {
            (data, response ,error) in
            // セッションを終了
            session.finishTasksAndInvalidate()
            // do try catch エラーハンドリング
            do {
                // JSONDecoderのインスタンス取得
                let decoder = JSONDecoder()
                // 受け取ったJSONデータをパース（解析）して格納
                let json = try decoder.decode(WeatherJson.self, from: data!)
                
//                                print(json)
                
                //リストの初期化
                self.weatherList.removeAll()
                var count = 0
                
                for item in json.daily {
                    
                    
                    
                    //取得してる数だけ処理
//                    for daily in dailys {
                        count += 1
                        
                        // UNIX時間 "dateUnix" をNSDate型 "date" に変換
                        let dateUnix: TimeInterval = TimeInterval(item.dt)
                        let date = NSDate(timeIntervalSince1970: dateUnix)

                        // NSDate型を日時文字列に変換するためのNSDateFormatterを生成
                        let formatter = DateFormatter()
                        
                        //yyyy年MM月dd日
                        formatter.dateFormat = "dd日"

                        // NSDateFormatterを使ってNSDate型 "date" を日時文字列 "dateStr" に変換
                        let dateStr: String = formatter.string(from: date as Date)
                       // print(dateStr)

                            //日付、天気をまとめて管理
                        //daily.dt⇨dateStr
                        let weather = WeatherItem(num: count, dt:dateStr , main: item.weather.first!.main, tempDay: item.temp.day, tempMin:item.temp.min ,tempMax: item.temp.max)
                            //weather配列へ追加
                    self.weatherList.append(weather)

               

                    print("リスト")
                    print(self.weatherList)
                    
                    let location = CLLocation(latitude: json.lat, longitude: json.lon)
                    getLocation(from: location) { placemark in
                        self.place = placemark.locality!
                    }

                }
            
//                let location = CLLocation(latitude: json.lat, longitude: json.lon)
//                getLocation(from: location) { placemark in
//                    self.place = placemark.locality!
//                }
                
            } catch {
                // エラー処理
                print("エラーが出ました")
            }
        })
        // ダウンロード開始
        task.resume()
    }
    
}
