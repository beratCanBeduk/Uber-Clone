//
//  LocationManager.swift
//  UberClone
//
//  Created by berat can beduk on 7.12.2022.
//

import CoreLocation


class LocationManager : NSObject ,ObservableObject{
   static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    
    @Published var userLocation : CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self 
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
}
 
