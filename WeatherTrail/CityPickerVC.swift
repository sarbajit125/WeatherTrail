//
//  CityPickerVC.swift
//  WeatherTrail
//
//  Created by comviva on 05/02/22.
//

import UIKit

class CityPickerVC: UIViewController {
    
    let lUtility = LocationUtility.instance

    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var currentL: UILabel!
    @IBOutlet weak var cityPicker: UIPickerView!
    
    @IBOutlet weak var check: UIButton!
    let cityList = ["Bangalore", "Mumbai", "Delhi", "Hyderabad"]
    let typeofForecast = ["Hourly","Daily" ]
    var isValid = false
    var selectedCity = ""
    var selectedlat:Double = 0.0
    var selectedLong:Double = 0.0
    var selectedForecastType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPicker.dataSource = self
        cityPicker.delegate = self
        cityText.delegate = self
        check.isEnabled=false
        
        //startTracking()
        
        // Do any additional setup after loading the view.
    }
    
    func startTracking(){
        if lUtility.startTracking() {
            print("Tracking Started")

        }
        else {
            print("Tracking not started..check permission")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func preferance(_ sender: Any) {
    }
    
    @IBAction func checkBtn(_ sender: Any) {
        if isValid == true{
            
            // show ConfirmVC
            
//            guard let vc = storyboard?.instantiateViewController(identifier: "confirmvc") as? weatherVC else {
//                print("Could not find confirmvc")
//                return
//            }
//            print(selectedCity)
//            vc.currentLocation=selectedCity
//           show(vc, sender: self)
            print("isValid true")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "confirmvc") as! weatherVC
            print(selectedCity)
            vc.currentLocation=selectedCity
            vc.currentLat = selectedlat
            vc.currentLong = selectedLong
            self.present(vc, animated: true, completion: nil)
        }
        else{
            print("button not working")
        }
        }
    
    @IBAction func findLocation(_ sender: Any) {
            //startTracking()
            lUtility.getCurrentAddress { (addr) in
                // Find the location from current co-ordinates
                self.currentL.text = "Current Address: \(addr)"
                print("Tracking ended")
            }
            isValid = true
            check.isEnabled = true
        }
     
    
}

extension CityPickerVC:UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component{
        case 0:
            return cityList.count
        default:
            return typeofForecast.count
        }
        
    }
}

extension CityPickerVC:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return cityList[row]
        }else{
            return typeofForecast[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(42)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            selectedCity = cityList[row]
            isValid = true
            check.isEnabled = true
            print("Tracking Started")
            lUtility.getGeoCoord(address: "\(selectedCity)") { (loc) in
                self.currentL.text = "\(self.selectedCity) co-ord: \(loc.coordinate.latitude), \(loc.coordinate.longitude)"
                self.selectedlat = loc.coordinate.latitude
                self.selectedLong = loc.coordinate.longitude
            }
            print("Tracking Ended")
        }else{
            selectedForecastType = typeofForecast[row]
            print("Selected Forecast type: \(selectedForecastType)")
        }
        
        

    }
}

extension CityPickerVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case cityText:
            let input = textField.text ?? ""
            print(" textfiled Tracking Started")
            lUtility.getGeoCoord(address: "\(input)") { (loc) in
                self.currentL.text = "\(input) co-ord: \(loc.coordinate.latitude), \(loc.coordinate.longitude)"
                self.selectedlat = loc.coordinate.latitude
                self.selectedLong = loc.coordinate.longitude
            }
            isValid = true
            check.isEnabled = true
            print("textfiled Tracking Ended")
                    
        default:
            print("Some Error...")
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case cityText:
            let input = textField.text ?? ""
            if cityList.contains(input){
                currentL.text = "Selected City:\(input)"
                isValid = true
                check.isEnabled = true
                print(input)
            }
            else{
                currentL.textColor = .red
                currentL.text = "\(input) city not found"
            }
        default:
            print("Error Found...")
        }
        
    }
}
