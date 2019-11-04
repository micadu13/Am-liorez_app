//
//  Calculation.swift
//  CountOnMe
//
//  Created by Michael Aidan on 28/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
class Calculation {
    var vc = ViewController()
    vc.
   
    
    var elements: [String] {
        return vc.textView.text.split(separator: " ").map { "\($0)" }
    }
    
}
