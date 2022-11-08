//
//  UIImageView + Extension.swift
//  Hotel
//
//  Created by Vadlet on 05.11.2022.
//

import UIKit

extension UIImageView {
    static func hotelImage() -> UIImageView {
        
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = .radius
        image.backgroundColor = .cellColor()
        return image
    }
}
