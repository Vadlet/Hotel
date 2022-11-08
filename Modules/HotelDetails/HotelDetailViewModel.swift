//
//  HotelDetailViewModel.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

import CoreLocation

protocol HotelDetailViewModelProtocol: AnyObject {
    var name: String { get }
    var address: String { get }
    var stars: String { get }
    var distance: String { get }
    var suites_availability: String { get }
    var image: String { get }
    var location: CLLocationCoordinate2D { get }
    func fetchHotels(completion: @escaping (String) -> Void, successCompletion: @escaping () -> Void)
    func fetchImage(id: String, completion: @escaping (Data) -> Void)
}

final class HotelDetailViewModel: HotelDetailViewModelProtocol {
    var name: String { detailHotelModel?.name ?? "" }
    
    var address: String {
        detailHotelModel?.address ?? ""
    }
    
    var stars: String {
        "Stars: \(String(detailHotelModel?.stars ?? 0))"
    }
    
    var distance: String {
        "Distance: \(String(detailHotelModel?.distance ?? 0))"
    }
    
    var suites_availability: String {
        "Suites availability: \(detailHotelModel?.suites_availability ?? "")"
    }
    
    var image: String {
        detailHotelModel?.image ?? ""
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: detailHotelModel?.lat ?? 0,
                               longitude: detailHotelModel?.lon ?? 0)
    }
    
    func fetchImage(id: String, completion: @escaping (Data) -> Void) {
        networkService.fetchImageData(imageID: id) { data in
                completion(data)
        }
    }
    
    func fetchHotels(completion: @escaping (String) -> Void, successCompletion: @escaping () -> Void) {
        networkService.fetchHotelData(id: id, dataType: [HotelModel.self]) { [weak self] result in
            switch result {
            case .success(let data):
                guard let self = self else { return }
                self.detailHotelModel = data
                successCompletion()
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    
    private let networkService: NetworkServiceProtocol
    
    private var detailHotelModel: HotelModel?
    var id: String
    
    init(id: Int, networkService: NetworkServiceProtocol) {
        self.id = String(id)
        self.networkService = networkService
    }
}
