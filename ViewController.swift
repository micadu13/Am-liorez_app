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
        calcul.addNumber(number: numberText)
        textView.text = calcul.text
    }
    
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        do
        {
            try calcul.addition()
            textView.text = calcul.text
        } catch Calculation.Error.cannotAddOperator {
            alertmessage()
        } catch {
            
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        do
        {
            try calcul.soustraction()
            textView.text = calcul.text
        }
        catch Calculation.Error.cannotAddOperator {
            alertmessage()
        } catch {
            
        }

    }
    
    
    @IBAction func tappedMultiplication(_ sender: UIButton) {
        
       do
        {
            try calcul.multiplication()
            textView.text = calcul.text
        }
        catch Calculation.Error.cannotAddOperator {
            alertmessage()
        } catch {
            
        }

    }
    
    
    @IBAction func tappedDivision(_ sender: UIButton) {
       do
        {
            try calcul.division()
            textView.text = calcul.text
        }
        catch Calculation.Error.cannotAddOperator {
            alertmessage()
        } catch {
            
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        do {
            try calcul.calculate()
            textView.text = calcul.text
        }
        catch Calculation.Error.expressionIsNotCorrect {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        catch Calculation.Error.expressionDoesNotHaveEnoughtElement{
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        catch {
            
        }
        
        
    }
    
    @IBAction func clean(){
        calcul.clear()
        textView.text = calcul.text
      
       
    }
    
}

