//
//  UIColor + Extension.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

import UIKit

extension UIColor {
    
  static func cellColor() -> UIColor {
      UIColor(named: "CellColor") ?? UIColor.gray
  }
  
  static func shadowColor() -> UIColor {
      UIColor(named: "ShadowColor") ?? UIColor.gray
  }
}
