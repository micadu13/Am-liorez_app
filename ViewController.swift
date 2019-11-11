//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calcul = Calculation(text:"")
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func alertmessage(){
        let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        textView.text.append(numberText)
    }
    
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calcul.canAddOperator {
            calcul.addition()
        }
        else  {
            alertmessage()
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calcul.canAddOperator {
            calcul.soustraction()
        } else {
            alertmessage()
        }
    }
    
    
    @IBAction func tappedMultiplication(_ sender: UIButton) {
        
        if calcul.canAddOperator {
            calcul.multiplication()
        } else {
            alertmessage()
        }
    }
    
    
    @IBAction func tappedDivision(_ sender: UIButton) {
        if calcul.canAddOperator {
            calcul.division()
        } else {
            alertmessage()
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calcul.expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calcul.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // Create local copy of operations
        var operationsToReduce = calcul.elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "*": result = left * right
            case "/": result = left / right 
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textView.text.append(" = \(operationsToReduce.first!)")
    }

}

