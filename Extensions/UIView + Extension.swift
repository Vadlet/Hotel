//
//  UIView + Extension.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

import UIKit

extension UIView {
    convenience init(cornerRadius: CGFloat) {
        self.init()
        self.layer.cornerRadius = cornerRadius
        backgroundColor = .cellColor()
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowColor = UIColor.shadowColor().cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}
