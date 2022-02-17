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
    
    @IBOutlet weak var windDir: UIImageView!
    var weatherList : [DailyResult] = []
    var currentLocation=""
    var currentLat:Double = 0.0
    var currentLong:Double = 0.0
    
    var Wutils = weatherUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.dataSource = self
        tbl.delegate = self
        currentL.text = "Location: \(currentLocation)"
        AFUtility.instance.getPopularMovies(Lat: currentLat, Long: currentLong, completion: { data in
            self.weatherList = data.daily
            self.tbl.reloadData()
        }) 
        print("currentLat:\(currentLat)")
        print("currentLong:\(currentLong)")
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
//    func getDate(dt:Double)->String{
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd MM yyyy"
//        let  stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(dt)))
//        return stringDate
//    }
    
    
    
    func getBackground(main:String){
        switch main{
        case "Clear":
            let bg = UIImageView(frame: UIScreen.main.bounds)
            bg.image = UIImage(named: "backgroundSunny")
            bg.contentMode = UIView.ContentMode.scaleAspectFit
            self.view.insertSubview(bg, at: 0)
        case "Clouds":
            let bg = UIImageView(frame: UIScreen.main.bounds)
            bg.image = UIImage(named: "backgroundCloudy")
            bg.contentMode = UIView.ContentMode.scaleAspectFit
            self.view.insertSubview(bg, at: 0)
        case "Rain":
            let bg = UIImageView(frame: UIScreen.main.bounds)
            bg.image = UIImage(named: "backgroundRainy")
            bg.contentMode = UIView.ContentMode.scaleAspectFit
            self.view.insertSubview(bg, at: 0)
        default:
            let bg = UIImageView(frame: UIScreen.main.bounds)
            bg.image = UIImage(named: "backgroundSunny")
            bg.contentMode = UIView.ContentMode.scaleAspectFit
            self.view.insertSubview(bg, at: 0)
        }
    }

}

extension weatherVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! WeatherCell
        let std = weatherList[indexPath.row]
        cell.contentView.backgroundColor = .darkGray

        print("Weather Main:\(std.weather[0].main)")
//        switch std.weather[0].main{
//        case "clear":
//            cell.forecastImg.image=UIImage(named: "sunny")
//        case "clouds":
//            cell.forecastImg.image=UIImage(named: "cloudy")
//        case "rain":
//            cell.forecastImg.image=UIImage(named: "rainy")
//        default:
//            cell.forecastImg.image=UIImage(named: "sunny")
//        }
        
        getBackground(main: std.weather[0].main)
        let windDegree = std.wind_deg
        windDir.image = Wutils.getWindArrow(dir: windDegree)
        let days = Wutils.getDate(dt: std.dt)
        print("\(days)")
        let imgURL = "http://openweathermap.org/img/wn/\(std.weather[0].icon)@2x.png"// HTTP does not work
        AFUtility.instance.downloadImage(imgURL: imgURL) { (imgData) in
            cell.forecastImg.image = UIImage(data: imgData)
        }
        forecastL.text = "\(std.weather[0].main)"
        cell.dayL.text = "\(days)"
        cell.maxT.text = "\(std.temp.max) \u{00B0}C"
        cell.minT.text = "\(std.temp.min) \u{00B0}C"
        
        
        return cell
    }
}

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
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let std = weatherList[indexPath.row]
        getBackground(main: std.weather[0].main) // Background does not change according to highligted row
        let windDegree = std.wind_deg
        windDir.image = Wutils.getWindArrow(dir: windDegree)
        print("Day:\(std.dt) Temp:\(std.temp.max)")
        temperatureL.text="\(std.temp.max)\u{00B0}C"
    }
}

extension LosslessStringConvertible{
    var string : String{.init(self)}
}
