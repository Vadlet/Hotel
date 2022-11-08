//
//  UILabel + Extension.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

import UIKit

extension UILabel {
  
  convenience init(text: String = "",
                   font: UIFont?,
                   color: UIColor = .black) {
    self.init()
      
    self.text = text
    self.textColor = color
    self.font = font
    adjustsFontSizeToFitWidth = true
    translatesAutoresizingMaskIntoConstraints = false
  }
}
