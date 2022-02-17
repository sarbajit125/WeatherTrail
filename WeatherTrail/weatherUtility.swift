//
//  weatherUtility.swift
//  WeatherTrail
//
//  Created by comviva on 17/02/22.
//

import Foundation
import UIKit


class weatherUtility{
    
    func getTime(dt:Double)->String{
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    
    func getWindArrow(dir:Int)->UIImage{
        switch dir{
        case let x where x == 0:
            return UIImage(systemName: "arrow.right")!
        case let x where x>0 && x<90:
            return UIImage(named: "northEast")!
        case let x where x == 90:
            return UIImage(systemName: "arrow.up")!
        case let x where x>90 && x<180:
            return UIImage(named: "northwest")!
        case let x where x == 180:
            return UIImage(systemName: "arrow.left")!
        case let x where x>180 && x<270:
            return UIImage(named: "southwest")!
        case let x where x == 270:
            return UIImage(systemName: "arrow.down")!
        case let x where x>270 && x<360:
            return UIImage(named: "southeast")!
        default:
            print("Error...")
            return UIImage(systemName: "arrow.right")!
        }
    }
    
    func getDate(dt:Double)->String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        let  stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(dt)))
        return stringDate
    }
    
    func getTeempUnit(selectedUnit:String)->[String]{
       
        switch selectedUnit{
        case "metric":
            var result:[String] = []
            result.append("\u{00B0}C")
            result.append("meter/sec")
            return result
        case "imperial":
            let result = ["\u{00B0}F","miles/hour"]
            return result
        default:
            let result = ["K","meter/sec"]
            return result
        }
    }

}
