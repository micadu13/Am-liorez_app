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
        else {
         
        }
    }
    
        func showAlert(on vc:UIViewController,with title:String, message:String)
    {
    let alert = UIAlertController(title: "Zéro!", message: "un opérateur est déja mis !", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    DispatchQueue.main.async {
    vc.present(alert, animated: true, completion: nil)
    }
        }
}
