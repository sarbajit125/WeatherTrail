//
//  weatherVC.swift
//  WeatherTrail
//
//  Created by comviva on 05/02/22.
//

import UIKit

class weatherVC: UIViewController {
    
    
    @IBOutlet weak var currentL: UILabel!
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var temperatureL: UILabel!
    @IBOutlet weak var forecastL: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var windDir: UIImageView!
    
    let forecastVM = ForecastWeatherViewModel()
    var currentLocation=""
    var currentLat:Double = 0.0
    var currentLong:Double = 0.0
    var currentUnit = ""
    var excludeThis = ""
    
    var Wutils = weatherUtility()
    
    var getCurrentUnit:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.dataSource = self
        tbl.delegate = self
        tbl.backgroundColor = UIColor.clear
        currentL.text = "Location: \(currentLocation)"

        forecastVM.getWeatherData(Lat: currentLat, Long: currentLong, unit: currentUnit, exclude: excludeThis) {
            self.tbl.reloadData()
        }
        
//        print("currentLat:\(currentLat)")
//        print("currentLong:\(currentLong)")
        print("ExludedForecast: \(excludeThis)")
        getCurrentUnit = Wutils.getTeempUnit(selectedUnit: currentUnit)
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - Table DataSource


extension weatherVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastVM.weatherList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! WeatherCell
        let std = forecastVM.weatherList[indexPath.row] //weatherList[indexPath.row]
        cell.contentView.backgroundColor = UIColor.clear

        print("Weather Main:\(std.weather[0].main)")
        bgImg.image = Wutils.getBackground(main: std.weather[0].main)
        let windDegree = std.wind_deg
        windDir.image = Wutils.getWindArrow(dir: windDegree)
        //let days = Wutils.getDate(dt: std.dt)
        let days = Wutils.getDay(dt: std.dt)
        print("\(days)")
        let imgURL = "http://openweathermap.org/img/wn/\(std.weather[0].icon)@2x.png"// HTTP does not work need change info.plist to make it work
        AFUtility.instance.downloadImage(imgURL: imgURL) { (imgData) in
            cell.forecastImg.image = UIImage(data: imgData)
        }
        forecastL.text = "\(std.weather[0].main)"
        cell.dayL.text = "\(days)"
        cell.maxT.text = "\(std.temp.max) \(getCurrentUnit[0])"
        cell.minT.text = "\(std.temp.min) \(getCurrentUnit[0])"
        temperatureL.text="\(std.temp.max)\(getCurrentUnit[0])"
        
        return cell
    }
}

// MARK: - Table DataDelegate


extension weatherVC:UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let std = weatherList[indexPath.row]
//        print("Day:\(std.day) Temp:\(std.maxT)")
//        temperatureL.text="\(std.maxT)\u{00B0}C"
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let dayName = UILabel()
//        dayName.text="Days"
//        return dayName
//    }
//
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        //let std = weatherList[indexPath.row]
        let std = forecastVM.weatherList[indexPath.row]
        let windDegree = std.wind_deg
        windDir.image = Wutils.getWindArrow(dir: windDegree)
        print("Day:\(std.dt) Temp:\(std.temp.max)")
        temperatureL.text="\(std.temp.max)\(getCurrentUnit[0])"
    }
}
