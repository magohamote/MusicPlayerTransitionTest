//
//  File.swift
//  habitat-jardin
//
//  Created by Coteries on 18/02/16.
//  Copyright © 2016 Coteries. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    func substringToIndex(to: Int) -> String {
        let nsSt = self as NSString
        return nsSt.substringToIndex(to)
    }
}

// ----------------------------------- App colors -----------------------------------------------------------

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

class myColor {

    class func planifyGrey() -> UIColor {
        return UIColor(rgb: 0x292929)
    }
    
    class func localGreen() -> UIColor {
        return UIColor(rgb: 0xc7da75)
    }
    
    class func localGray() -> UIColor {
        return UIColor(rgb: 0x666666)
    }
    
    class func goodAnswer() -> UIColor {
        return UIColor(rgb: 0x9dbc24)
    }
    
    class func wrongAnswer() -> UIColor {
        return UIColor(rgb: 0xdf0b25)
    }
    
    class  func unselectedAnswer() -> UIColor {
        return UIColor(rgb: 0xd1e08d)
    }
    
}

struct QuestionCount {
    static var numberOfQuestion = 0
    static var numberOfLogos = 0
}
