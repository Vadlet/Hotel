//
//  HotelListCellViewModel.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

protocol HotelListCellViewModelProtocol: AnyObject {
    var name: String { get }
    var address: String { get }
    var stars: String { get }
    var distance: String { get }
    var suitesAvailability: String { get }
}

final class HotelListCellViewModel: HotelListCellViewModelProtocol {
 
    var name: String {
        hotelsModel.name
    }
    
    var address: String {
        hotelsModel.address
    }
    
    var stars: String {
        "Stars: \(String(hotelsModel.stars))"
    }
    
    var distance: String {
        "Distance: \(String(hotelsModel.distance))"
    }
    
    var suitesAvailability: String {
        "Suites availability: \(hotelsModel.suites_availability)"
    }
    
    var hotelsModel: HotelsModel
    
    init(hotelsModel: HotelsModel) {
        self.hotelsModel = hotelsModel
    }
}
