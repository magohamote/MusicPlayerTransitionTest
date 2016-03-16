//
//  Colors.swift
//  MusicPlayerTransition
//
//  Created by Coteries on 15/03/16.
//  Copyright © 2016 xxxAIRINxxx. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    let colorTop = UIColor.clearColor().CGColor
    let colorBottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75).CGColor
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.0, 1.0]
    }
}