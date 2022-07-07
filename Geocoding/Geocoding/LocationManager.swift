//
//  LocationManager.swift
//  Geocoding
//
//  Created by Koty Stannard on 7/7/22.
//

import Foundation
import CoreLocation
import MapKit

struct Location {
    
    let name: String
    let city: String
    let state: String
    let country: String
    let coordinate: CLLocationCoordinate2D?
}

class LocationManager {
    
    static let shared = LocationManager()
    
    public func findLocation(with query: String, completion: @escaping (([Location]) -> Void)) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            
            let models: [Location] = places.compactMap { place in
                var name = ""
                var city = ""
                var state = ""
                var country = ""
                
                if let placeName = place.name {
                    name += placeName
                }
                
                if let locality = place.locality {
                    city += locality
                }
                
                if let stateOrProvince = place.administrativeArea {
                    state += stateOrProvince
                }
                
                if let placeCountry = place.country {
                    country += placeCountry
                }
                
                let result = Location(name: name, city: city, state: state, country: country, coordinate: place.location?.coordinate)
                
                return result
            }
            
            completion(models)
        }
    }
}
