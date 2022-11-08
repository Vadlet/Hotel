//
//  HotelModel.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

struct HotelsModel: Decodable {
    let id: Int
    let name: String
    let address: String
    let stars: Double
    let distance: Double
    let suites_availability: String
}

struct HotelModel: Decodable {
    let id: Int
    var name: String
    let address: String
    let stars: Double
    let distance: Double
    let image: String
    let suites_availability: String
    let lat: Double
    let lon: Double
}

typealias ListHotelsModel = [HotelsModel]
