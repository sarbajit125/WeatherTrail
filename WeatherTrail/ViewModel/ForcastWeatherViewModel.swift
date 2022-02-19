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

    let model = AFUtility.instance   // strong reference of model
    
    func sevenDayForecast(Lat:Double,Long:Double,unit:String,completion: @escaping()->Void){
        model.getDailyData(Lat: Lat, Long: Long, unit: unit) { data in
            self.weatherList = data.daily
            completion() // update to View Controller
        }
    }
    
    func twentyFourHoursForecast(Lat:Double,Long:Double,unit:String,completion: @escaping()->Void){
        model.getHourlyData(Lat: Lat, Long: Long, unit: unit) { data in
            self.hourlyList = data.hourly
            completion()
        }
    }
    
    func getImages(imgURL:String,completion: @escaping (Data)->Void){
        model.downloadImage(imgURL: imgURL) { Data in
            completion(Data)
        }
    }
    
}
