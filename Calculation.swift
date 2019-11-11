//
//  Calculation.swift
//  CountOnMe
//
//  Created by Michael Aidan on 28/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

import UIKit
class Calculation {

    var text:String
    
    
    init(text:String) {
        self.text = text
    }
    
    var elements: [String]{
        return text.split(separator: " ").map {"\($0)"}
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    var expressionHaveResult: Bool {
        return text.firstIndex(of: "=") != nil
    }
    
   
    func addition(){
        if canAddOperator == true
        {
            text.append(" + ")
        }
    }
    
    func soustraction(){
        if canAddOperator == true {
            text.append(" - ")
        }
    }
    
    func multiplication(){
         if canAddOperator == true {
                   text.append(" * ")
               }
    }
    func division(){
            if canAddOperator == true {
                      text.append(" / ")
                  }
       }
    
}
