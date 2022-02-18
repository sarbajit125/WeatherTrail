//
//  HourlyVc.swift
//  WeatherTrail
//
//  Created by comviva on 16/02/22.
//

import UIKit

class HourlyVc: UIViewController {
    
    @IBOutlet weak var currentL: UILabel!
    @IBOutlet weak var windDir: UIImageView!
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var tempL: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    
    var currentLocation=""
    var currentLat:Double = 0.0
    var currentLong:Double = 0.0
    var currentUnit = ""
    var LocalDate = weatherUtility()
    var forecastVM = ForecastWeatherViewModel()
    
    var getCurrentUnit:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.dataSource = self
        tbl.delegate = self
        tbl.backgroundColor = UIColor.clear
        currentL.text = "Location: \(currentLocation)"
//        AFUtility.instance.getHourlyData(Lat: currentLat, Long: currentLong, unit: currentUnit) { data in
//            self.hourlyList = data.hourly
//            self.tbl.reloadData()
//        }
        forecastVM.twentyFourHoursForecast(Lat: currentLat, Long: currentLong, unit: currentUnit) {
            self.tbl.reloadData()
        }
        print("currentLat:\(currentLat)")
        print("currentLong:\(currentLong)")
        getCurrentUnit = LocalDate.getTeempUnit(selectedUnit: currentUnit)
        
        
        

        // Do any additional setup after loading the view.
    }
    

    
}
// MARK: - Table DataSource


extension HourlyVc:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //return (hourlyList.count-24)
        return (forecastVM.hourlyList.count-24)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourCell", for: indexPath) as! HourlyCell
//        let std = hourlyList[indexPath.row]
        let std = forecastVM.hourlyList[indexPath.row]
        cell.contentView.backgroundColor = UIColor.clear
        print("Weather Main:\(std.weather[0].main)")
        bgImg.image = LocalDate.getBackground(main: std.weather[0].main)
        let windDegree = std.wind_deg
        windDir.image = LocalDate.getWindArrow(dir: windDegree)
        let days = LocalDate.getTime(dt: std.dt)
        print("\(days)")
        let imgURL = "http://openweathermap.org/img/wn/\(std.weather[0].icon)@2x.png"// HTTP does not work
        forecastVM.getImages(imgURL: imgURL) { (imgData) in
            cell.conditionsL.image = UIImage(data: imgData)
        }
        
        tempL.text = "\(std.temp) \(getCurrentUnit[0])"
        cell.tempCellL.text="\(std.temp) \(getCurrentUnit[0])"
        cell.hourL.text = "\(days)"
        cell.humidityL.text = "Humidity:\(std.humidity)%"
        cell.feelLikeL.text = "Feels like \(std.feels_like)\(getCurrentUnit[0])"
        
        return cell
    }
    
    
}
// MARK: - Table DataDelegate


extension HourlyVc:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let std = forecastVM.hourlyList[indexPath.row]
        let windDegree = std.wind_deg
        windDir.image = LocalDate.getWindArrow(dir: windDegree)
        print("Day:\(std.dt) Temp:\(std.feels_like )\(getCurrentUnit[0])")
        tempL.text="\(std.temp)\(getCurrentUnit[0])"
    }
}
