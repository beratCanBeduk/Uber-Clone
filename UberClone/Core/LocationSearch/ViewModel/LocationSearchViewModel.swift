//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by berat can beduk on 8.12.2022.
//

import Foundation
import MapKit

class LocationSearchViewModel : NSObject,ObservableObject {
    
    
    @Published var result = [MKLocalSearchCompletion]()

    @Published var selectedLocationCoordinate : CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    var queryFragment : String = ""{
        didSet{
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation : CLLocationCoordinate2D?
    // MARK: Lifecycle
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    // MARK: Helpers
    
    func selectLocation(localSearch : MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print("DEBUG : \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch : MKLocalSearchCompletion,completion: @escaping MKLocalSearch.CompletionHandler)
    {
        let searchRequest = MKLocalSearch.Request()
        searchRequest
            .naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
    
    func computeRidePrice(forType type : RideType) -> Double {
        guard let coordinate = selectedLocationCoordinate else {return 0.0}
        guard let userLocation = self.userLocation else {return 0.0}
        
        let userLocations = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let tripDistanceInMeters = userLocations.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
        
    }
    
}


extension LocationSearchViewModel : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
