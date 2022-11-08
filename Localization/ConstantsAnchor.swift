//
//  ConstantsAnchor.swift
//  Hotel
//
//  Created by Vadlet on 03.11.2022.
//

import UIKit
import CoreLocation

extension CGFloat {
    
    // Constants
    static let offset: CGFloat = 10
    static let inset: CGFloat = -10
    static let smallOffSet: CGFloat = 5
    static let smallInSet: CGFloat = -5
    static let stackOffset: CGFloat = 20
    static let stackInset: CGFloat = -20
    static let radius: CGFloat = 10
    static let smallRadius: CGFloat = 5
    
    // HeightSize
    static let heightMultiplier: CGFloat = 0.3
    
    // CromImage
    static let offsetX: CGFloat = 1
    static let offsetY: CGFloat = 1
    static let cropWith: CGFloat = 2
    static let cropHeight: CGFloat = 2
}

extension CLLocationDistance {
    // Zoom adress to MapKit
    static let latZoomMap: CLLocationDistance = 1000
    static let lonZoomMap: CLLocationDistance = 1000
}
