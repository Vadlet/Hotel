//
//  HotelListViewModel.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

import Foundation

protocol HotelListViewModelProtocol: AnyObject {
    func numberOfCell() -> Int
    func fetchHotels(completion: @escaping (String) -> Void, successCompletion: @escaping () -> Void)
    func returnCell(at indexPath: IndexPath) -> HotelListCellViewModelProtocol?
    func returnDetailViewModel(at indexPath: IndexPath) -> HotelDetailViewModelProtocol?
    func filterHotels(at segmentIndex: Int)
}

final class HotelListViewModel: HotelListViewModelProtocol {
    
    // MARK: - Properties
    private var hotelsModel: ListHotelsModel?
    private let networkService: NetworkServiceProtocol
    
    // MARK: - Initializers
    init(_ networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func fetchHotels(completion: @escaping (String) -> Void, successCompletion: @escaping () -> Void) {
        networkService.fetchHotelsData(dataType: ListHotelsModel.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.hotelsModel = data
                successCompletion()
            case .failure(let error):  
                completion(error.localizedDescription)
            }
        }
    }
    
    func numberOfCell() -> Int {
        guard let data = hotelsModel?.count else { return 0 }
        return data
    }
    
    func returnCell(at indexPath: IndexPath) -> HotelListCellViewModelProtocol? {
        guard let data = hotelsModel else { return nil }
        return HotelListCellViewModel(hotelsModel: data[indexPath.row])
    }
    
    func returnDetailViewModel(at indexPath: IndexPath) -> HotelDetailViewModelProtocol? {
        guard let data = hotelsModel else { return nil }
        return HotelDetailViewModel(id: data[indexPath.row].id,
                                    networkService: networkService)
    }
    
    // MARK: - FilterHotels Method
    func filterHotels(at segmentIndex: Int) {
        var viewModels: [HotelsModel]?
        if segmentIndex == 0 {
            viewModels = hotelsModel
            hotelsModel = viewModels?.sorted(by: { $0.distance < $1.distance })
        } else {
            viewModels = hotelsModel
            hotelsModel = viewModels?.sorted(by: {
                let first = $0.suites_availability.compactMap { $0.wholeNumberValue }.reduce(0, +)
                let second = $1.suites_availability.compactMap { $0.wholeNumberValue }.reduce(0, +)
                return first > second})
        }
    }
}
