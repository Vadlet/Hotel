//
//  HotelListViewControllerBuilder.swift
//  Hotel
//
//  Created by Vadlet on 05.11.2022.
//

import UIKit

enum HotelListBuilder {
    static func build(_ networkService: NetworkServiceProtocol) -> (UIViewController) {
        
        let viewModel = HotelListViewModel(networkService)
        let vc = HotelListViewController(viewModel)
        return vc
    }
}
