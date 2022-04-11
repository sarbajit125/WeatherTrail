//
//  ForcastWeatherViewModel.swift
//  WeatherTrail
//
//  Created by comviva on 18/02/22.
//

import Foundation

class ForecastWeatherViewModel{
    var weatherList : [DailyResult] = []
    var hourlyList : [HourlyResult] = []
    var getTimezone = ""

    let model = AFUtility.instance   // strong reference of model
       
//    func twentyFourHoursForecast(Lat:Double,Long:Double,unit:String,completion: @escaping()->Void){
//        model.getHourlyData(Lat: Lat, Long: Long, unit: unit) { data in
//            self.hourlyList = data.hourly
//            completion()
//        }
//    }
    
    func getImages(imgURL:String,completion: @escaping (Data)->Void){
        model.downloadImage(imgURL: imgURL) { Data in
            completion(Data)
        }
    }
    
    func getWeatherData(Lat:Double,Long:Double,unit:String,exclude:String,completion: @escaping ()->Void){
        model.forecastData(Lat: Lat, Long: Long, unit: unit, exclude: exclude) { data in
            if exclude == "hourly"{
                let forecast = data as! DailyForecast
                self.weatherList = forecast.daily
                self.getTimezone = forecast.timezone
                completion()
            }else{
                let forecast = data as! HourlyForecast
                self.hourlyList = forecast.hourly
                self.getTimezone = forecast.timezone
                completion()
            }
            
        }
    }
}
