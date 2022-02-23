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
    
    @IBOutlet weak var PickerBg: UIImageView!
    
    @IBOutlet weak var showMenuButton: UIButton!
    @IBOutlet weak var check: UIButton!
    let cityList = ["Bangalore", "Mumbai", "Delhi", "Hyderabad"]
    let typeofForecast = ["daily","hourly"]
    var isValid = false
    var selectedCity = ""
    var selectedlat:Double = 0.0
    var selectedLong:Double = 0.0
    var selectedForecastType = "daily"
    var selectedUnit = "metric"
    var excludeThis = "hourly"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityPicker.dataSource = self
        cityPicker.delegate = self
        cityText.delegate = self
        check.isEnabled=false
        PickerBg.image = UIImage(named: "second")
        configureButtonMenu()
        navigationItem.title = "Settings"
        setNavigation()
        
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
    
    func setNavigation(){
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    @IBAction func checkBtn(_ sender: Any) {
        if isValid == true{
            
            if selectedForecastType == "hourly"{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HourlyVC") as! HourlyVc
                print(selectedCity)
                vc.currentLocation=selectedCity
                vc.currentLat = selectedlat
                vc.currentLong = selectedLong
                vc.currentUnit = selectedUnit
                vc.excludeThis = excludeThis
                //self.show(vc, animated: true, completion: nil)
                self.show(vc, sender: nil)
            }else{
                print("isValid true")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "confirmvc") as! weatherVC
                print(selectedCity)
                vc.currentLocation=selectedCity
                vc.currentLat = selectedlat
                vc.currentLong = selectedLong
                vc.currentUnit = selectedUnit
                vc.excludeThis = excludeThis
                //self.show(vc, animated: true, completion: nil)
                self.show(vc, sender: nil)
            }
            
           
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
                self.selectedCity = "\(addr)"
                print("Tracking ended")
            }
            isValid = true
            check.isEnabled = true
        }
    func configureButtonMenu(){
        var menuItems: [UIAction] {
            return [
                UIAction(title: "Celsius", image: UIImage(named: "degree-celsius"), handler: { (unit) in
                    self.selectedUnit = "metric"
                    self.showMenuButton.setTitle("Selected : Celsius", for: .normal)
                    self.showMenuButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
                    print("Choosen Unit is \(self.selectedUnit)")
                }),
                UIAction(title: "Fahrenheit", image: UIImage(named: "degree-fahrenheit"), handler: { (_) in
                    self.selectedUnit = "imperial"
                    self.showMenuButton.setTitle("Selected : Fahrenheit", for: .normal)
                    self.showMenuButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
                    print("Choosen Unit is \(self.selectedUnit)")
                }),
                UIAction(title: "Kelvin", image: UIImage(named: "kelvin-temperature"), handler: { (_) in
                    self.selectedUnit = "standard"
                    self.showMenuButton.setTitle("Selected : Kelvin", for: .normal)
                    self.showMenuButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
                    print("Choosen Unit is \(self.selectedUnit)")
                })
            ]
        }

        var demoMenu: UIMenu {
            return UIMenu(title: "Select Your Preference ", image: nil, identifier: nil, options: [], children: menuItems)
        }
        
        showMenuButton.menu = demoMenu
            showMenuButton.showsMenuAsPrimaryAction = true

    }
    
    
    @IBAction func checkTypeOfForecast(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            selectedForecastType = typeofForecast[0]
            print("Type of forecast: \(selectedForecastType)")
            excludeThis = "hourly"
        case 1:
            selectedForecastType = typeofForecast[1]
            print("Type of forecast: \(selectedForecastType)")
            excludeThis = "daily"
        default:
           print("Faced Error...")
        }
        
    }
    
}

extension CityPickerVC:UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList.count
    
    }
}

extension CityPickerVC:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return cityList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(42)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedCity = cityList[row]
            print("Tracking Started")
            lUtility.getGeoCoordOptional(address: "\(selectedCity)") { (locations) in
                if let loc = locations{
                    self.isValid = true
                    self.check.isEnabled = true
                    self.currentL.text = "\(self.selectedCity) co-ord: \(loc.coordinate.latitude), \(loc.coordinate.longitude)"
                    self.selectedlat = loc.coordinate.latitude
                    self.selectedLong = loc.coordinate.longitude
                }else{
                    print("Error in getting location GeoCo-ordinates")
                }
                
            }
            print("Tracking Ended")

    }
}

extension CityPickerVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case cityText:
            let input = textField.text ?? ""
            print(" textfiled Tracking Started")
            lUtility.getGeoCoordOptional(address: "\(input)") { (locations) in
                if let loc = locations{
                    self.currentL.text = "\(input) co-ord: \(loc.coordinate.latitude), \(loc.coordinate.longitude)"
                    self.selectedlat = loc.coordinate.latitude
                    self.selectedLong = loc.coordinate.longitude
                    self.isValid = true
                    self.check.isEnabled = true
                }else{
                    self.currentL.text = "Unable to get Co-ordinates of location"
                }
                
            }
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
