//
//  WeatherData.swift
//  WeatherTrail
//
//  Created by comviva on 05/02/22.
//

import Foundation

struct DailyResult:Codable{
    var dt : Double
    var humidity : Int
    var temp : temp
    var wind_deg :Int
    var weather : [weather]
    
    
}

struct weather:Codable{
    var id:Int
    var main:String
    var icon:String
}

struct temp:Codable{
    var max:Float
    var min:Float
}

struct DailyForecast:Codable{
    var daily:[DailyResult]
}

// 24Hours Forecast
struct HourlyResult:Codable{
    var dt : Double
    var temp : Double
    var feels_like : Double
    var humidity : Double
    var wind_deg : Int
    var weather : [weather]
    
}

struct HourlyForecast:Codable{
    var hourly : [HourlyResult]
}
