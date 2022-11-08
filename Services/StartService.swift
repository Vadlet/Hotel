//
//  StartService.swift
//  Hotel
//
//  Created by Vadlet on 05.11.2022.
//

import UIKit

final class StartService {
    
    private var window: UIWindow?
    
    init(_ window: UIWindow) {
        self.window = window
        configWindow()
    }
    
    private func configWindow() {
        let networkService = NetworkService()
        
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: HotelListBuilder.build(networkService))
    }
}
