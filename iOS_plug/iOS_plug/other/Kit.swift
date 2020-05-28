//
//  Kit.swift
//  iOS_plug
//
//  Created by wiley on 2020/5/28.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    public convenience init(rgb: Int, alpha: CGFloat = 1) {
        
        let red = CGFloat(((rgb & 0xff0000) >> 16)) / 255.0
        let green = CGFloat(((rgb & 0xff00) >> 8)) / 255.0
        let blue = CGFloat(((rgb & 0xff))) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
