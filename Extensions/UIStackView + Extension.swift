//
//  UIStackView + Extension.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

import UIKit

extension UIStackView {
  convenience init(arrangedSubviews: [UIView],
                   axis: NSLayoutConstraint.Axis,
                   spacing: CGFloat) {
    self.init(arrangedSubviews: arrangedSubviews)
      
    self.axis = axis
    self.spacing = spacing
    translatesAutoresizingMaskIntoConstraints = false
  }
}
