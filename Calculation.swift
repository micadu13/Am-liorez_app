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
        case CannotUseZero
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
    
    func addOperator(_ op: String) throws {
        if canAddOperator == true
        {
            text.append(" \(op) ")
        } else {
            throw Error.cannotAddOperator
        }
    }
    
    func addition() throws {
        try addOperator("+")
    }
    
    func soustraction() throws {
        try addOperator("-")
    }
    
    func multiplication() throws {
        try addOperator("*")
    }
    func division() throws {
        try addOperator("/")
    }
    
    
    func calculate() throws{
        
        guard expressionHaveEnoughElement
            else {
                throw Error.expressionDoesNotHaveEnoughtElement
        }
        
        guard expressionIsCorrect
            else {
                throw Error.expressionIsNotCorrect
        }
        
        let op1 =  try resolvePrioritizeOperation(elements: elements)
        let result = resolveOperations(elements: op1)
        text.append(" = \(result[0])")
        
    }
    
    func recalcul(){
        if expressionHaveResult == true {
            clear()
            do {
              try calculate()
            }
            catch{
                
            }
           
        }
    }
    
    
    func resolvePrioritizeOperation  (elements: [String]) throws -> [String]  {
        
        var operationsToReduce = elements
        while operationsToReduce.contains("*") || operationsToReduce.contains("/") {
            if let index = operationsToReduce.firstIndex(of: "*") ?? operationsToReduce.firstIndex(of: "/") {
                
                
                let left = Double(operationsToReduce[index-1])!
                let operand = operationsToReduce[index]
                let right = Double(operationsToReduce[index+1])!
                
                var result: Double
                
                switch operand {
                    
                case "*": // 1st priority
                    result = left * right
                case "/": // 1st priority
                    if right != 0  {
                        
                        result = left / right
                    }
                    else
                    {
                        throw  Error.CannotUseZero
                    }
                    
                default: fatalError("Unknown operator !")
                }
                operationsToReduce[index-1] = "\(result)"
                operationsToReduce.remove(at: index)
                operationsToReduce.remove(at: index)
            }
            
        }
        return operationsToReduce
    }
    
    func resolveOperations(elements: [String]) -> [String] {
        var operationsToReduce = elements
        while operationsToReduce.contains("+") || operationsToReduce.contains("-")
        {
            if let index = operationsToReduce.firstIndex(of: "+") ?? operationsToReduce.firstIndex(of: "-")
            {
                let left = Double(operationsToReduce[index-1])!
                let operand = operationsToReduce[index]
                let right = Double(operationsToReduce[index+1])!
                
                var result: Double
                
                switch operand {
                case "+": //3rd priority
                    result = left + right
                    
                case "-": //4th priorrity
                    result = left - right
                    
                    
                default: fatalError("Unknown operator !")
                }
                
                operationsToReduce[index-1] = "\(result)"
                operationsToReduce.remove(at: index)
                operationsToReduce.remove(at: index)
                
            }
        }
        return operationsToReduce
    }
    
    func clear(){
        text = ""
    }
    
}

