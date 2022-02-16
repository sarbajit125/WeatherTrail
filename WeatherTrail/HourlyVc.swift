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
    
    var hourlyList : [HourlyResult] = []
    var currentLocation=""
    var currentLat:Double = 0.0
    var currentLong:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.dataSource = self
        tbl.delegate = self
        currentL.text = "Location: \(currentLocation)"
        AFUtility.instance.getHourlyData(Lat: currentLat, Long: currentLong) { data in
            self.hourlyList = data.hourly
            self.tbl.reloadData()
        }
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
    func getDate(dt:Double)->String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        let  stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(dt)))
        return stringDate
    }
    
    func getWindArrow(dir:Int){
        switch dir{
        case let x where x == 0:
            windDir.image=UIImage(systemName: "arrow.right")
        case let x where x>0 && x<90:
            windDir.image=UIImage(named: "northeast")
        case let x where x == 90:
            windDir.image=UIImage(systemName: "arrow.up")
        case let x where x>90 && x<180:
            windDir.image=UIImage(named: "northwest")
        case let x where x == 180:
            windDir.image=UIImage(systemName: "arrow.left")
        case let x where x>180 && x<270:
            windDir.image=UIImage(named: "southwest")
        case let x where x == 270:
            windDir.image=UIImage(systemName: "arrow.down")
        case let x where x>270 && x<360:
            windDir.image=UIImage(named: "southeast")
        default:
            print("Error...")
        }
    }

}

extension HourlyVc:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hourlyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourCell", for: indexPath) as! HourlyCell
        let std = hourlyList[indexPath.row]
        print("Weather Main:\(std.weather[0].main)")
        
        let windDegree = std.wind_deg
        getWindArrow(dir: windDegree)
        let days = getDate(dt: std.dt)
        print("\(days)")
        let imgURL = "http://openweathermap.org/img/wn/\(std.weather[0].icon)@2x.png"// HTTP does not work
        AFUtility.instance.downloadImage(imgURL: imgURL) { (imgData) in
            cell.conditionsL.image = UIImage(data: imgData)
        }
        
        tempL.text = "\(std.temp) \u{00B0}C"
        cell.tempCellL.text="\(std.temp) \u{00B0}C"
        cell.hourL.text = "\(days)"
        cell.humidityL.text = "\(std.humidity)"
        cell.feelLikeL.text = "\(std.feels_like)"
        
        return cell
    }
    
    
}

extension HourlyVc:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let std = hourlyList[indexPath.row]
        let windDegree = std.wind_deg
        getWindArrow(dir: windDegree)
        print("Day:\(std.dt) Temp:\(std.feels_like )")
        tempL.text="\(std.temp)\u{00B0}C"
    }
}
