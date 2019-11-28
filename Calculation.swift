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
    
    enum Error: Swift.Error {
        case cannotAddOperator
        case expressionIsNotCorrect
        case expressionDoesNotHaveEnoughtElement
    }
    
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
    
    func addNumber(number: String) {
        text.append("\(number)")
    }
    
    func addition() throws {
        if canAddOperator == true
        {
            text.append(" + ")
        } else {
            throw Error.cannotAddOperator
        }
    }
    
    func soustraction() throws {
        if canAddOperator == true {
            text.append(" - ")
        }
        else
        {
            throw Error.cannotAddOperator
        }
    }
    
    func multiplication() throws {
        if canAddOperator == true {
            text.append(" * ")
        }
        else
        {
            throw Error.cannotAddOperator
        }
    }
    func division() throws {
        if canAddOperator == true {
            text.append(" / ")
        }
        else {
            throw Error.cannotAddOperator
        }
    }
    
    func clear(){
        text = ""
    }
    
    
    func calculate() throws{
        
        guard expressionIsCorrect
            else {
                throw Error.expressionIsNotCorrect
                
        }
        
        guard expressionHaveEnoughElement
            else {
                throw Error.expressionDoesNotHaveEnoughtElement
                
        }
        
        firstpriority()
        secondpriority()
        
    }
    
     func firstpriority(){
            var operationsToReduce = elements
               while operationsToReduce.contains("*") || operationsToReduce.contains("/") {
                   if let index = operationsToReduce.firstIndex(of: "*") ?? operationsToReduce.firstIndex(of: "/") {
                       
                       let left = Int(operationsToReduce[index-1])!
                       let operand = operationsToReduce[index]
                       let right = Int(operationsToReduce[index+1])!
                       
                       var result: Int
                       
                       switch operand {
                           
                       case "*": // 1st priority
                           result = left * right
                       case "/"://2d priority
                           result = left / right
                           
                       default: fatalError("Unknown operator !")
                       }
                       
                       operationsToReduce[index-1] = "\(result)"
                       operationsToReduce.remove(at: index)
                       operationsToReduce.remove(at: index)
                   }
                   
               }
               
           }
    
    func secondpriority(){
        var operationsToReduce = elements
        while operationsToReduce.contains("+") || operationsToReduce.contains("-")
        {
            if let index = operationsToReduce.firstIndex(of: "+") ?? operationsToReduce.firstIndex(of: "-")
            {
                let left = Int(operationsToReduce[index-1])!
                let operand = operationsToReduce[index]
                let right = Int(operationsToReduce[index+1])!
                
                var result: Int
                
                switch operand {
                case "+": //3rd priority
                    result = left + right
                case "-": //4th priorrity
                    result = left - right
                    
                default: fatalError("Unknown operator !")
                }
                
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
                
            }
        }
    }
    
}

