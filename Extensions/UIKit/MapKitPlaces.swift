//
//  MapKitPlaces.swift
//  Hotel
//
//  Created by Vadlet on 06.11.2022.
//

import MapKit

class MapKitPlaces: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?,
         locationName: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
