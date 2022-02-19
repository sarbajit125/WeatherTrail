//
//  LocationUtility.swift
//  WeatherTrail
//
//  Created by comviva on 12/02/22.
//

import Foundation
import CoreLocation

// Singleton class
class LocationUtility : NSObject, CLLocationManagerDelegate {
    
    var lManager : CLLocationManager
    var currentLocation : CLLocation?
    var isPermissionGranted = false
    
    private override init() {
        
        
        lManager = CLLocationManager()
        lManager.requestWhenInUseAuthorization()
        lManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        super.init()
        lManager.delegate = self
    }
    
    static var instance = LocationUtility()
    
    func startTracking() -> Bool{
        
        if isPermissionGranted {
            lManager.startUpdatingLocation()
            return true
        }
        
        return false
    }
    
    func stopTracking() -> Bool {
        
        if isPermissionGranted {
            lManager.stopUpdatingLocation()
            return true
        }
        return false
    }
    
    func getCurrentAddress(completion: @escaping (String) -> Void ){
        // geocoding
        
        let gc = CLGeocoder()
        if let loc = currentLocation {
            gc.reverseGeocodeLocation(loc) { (placeResult, err) in
                
                if let addr = placeResult?.first {
                    let streetAddr = "\(addr.subLocality ?? ""), \(addr.locality ?? ""), \(addr.country ?? ""), \(addr.administrativeArea ?? "")"
                    
                    print("Address: \(streetAddr)")
                    
                    completion(streetAddr)
                }
            }
        }
    }
    
    
    func getGeoCoord(address: String, completion: @escaping (CLLocation) -> Void){
        // forward geocoding
        let gc = CLGeocoder()
        
        gc.geocodeAddressString(address) { (result, err) in
            
            if let place = result?.first {
                if let loc = place.location {
                    print("Lat:\(loc.coordinate.latitude)")
                    completion(loc)
                }
                else{
                    print("Unable to co-ordinates of the location")
                    
                }
            }
            else{
                print("location not found. Error:\(err?.localizedDescription ?? "...")")
                
            }
        }
    }
    
    //Test
    func getGeoCoordOptional(address: String, completion: @escaping (CLLocation?) -> Void){
        // forward geocoding
        let gc = CLGeocoder()
        
        gc.geocodeAddressString(address) { (result, err) in
            
            if let place = result?.first {
                if let loc = place.location {
                    print("Lat:\(loc.coordinate.latitude)")
                    completion(loc)
                }
                else{
                    print("Unable to co-ordinates of the location")
                    completion(nil)
                    
                }
            }
            else{
                print("location not found. Error:\(err?.localizedDescription ?? "...")")
                completion(nil)
                
            }
        }
    }

    
    
    // From delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("Location updated..")
        if let loc = locations.last {
            currentLocation = loc
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status{
            
        
        case .denied:
            isPermissionGranted = false
            print("Denied")
        
        case .authorizedWhenInUse:
            isPermissionGranted = true
            print("Granted")
            let _ = startTracking()
        default:
            isPermissionGranted = false
            print("Unknown auth")
        }
        
    }
    
    
    
}
