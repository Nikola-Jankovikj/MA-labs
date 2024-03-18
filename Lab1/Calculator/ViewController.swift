//
//  ViewController.swift
//  Calculator
//
//  Created by Nikola Jankovikj on 18.3.24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtField: UITextField!
    
    var result: Float? = 0
    var didPressOperation: Bool = false
    var lastOperationPressed : String?
    var firstTime: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastOperationPressed = ""
        txtField.text = "0"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapBtn(_ sender: UIButton) {
        guard let btnText = sender.titleLabel?.text
        else{
            return
        }
        
        switch btnText{
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            addToTextField(text: btnText)
            
        case "+", "-", "x", "/", "%":
           operatorPressed(operation: btnText)
            
        case "=":
            equalsPressed()
            
        case "+-":
            toggleNegativeNumber()
            
        case "AC":
            clear()
            
        case ".":
            addPointForDecimal()
            
        default:
            print("Undefined")
        }
    }
    
    func addToTextField(text: String) {
        if didPressOperation {
            txtField.text = text
            didPressOperation = false
        }
        
        else {
            if txtField.text == "0" {
                txtField.text = text
            }
            else {
                txtField.text = (txtField.text ?? "") + text
            }
        }
    }
    
    func operatorPressed(operation: String){
        
        didPressOperation = true
        
        switch lastOperationPressed {
        case "+":
            result = (result ?? 0) + (Float(txtField.text ?? "0") ?? 0)
            txtField.text = String(result ?? 0)
        case "-":
            result = (result ?? 0) - (Float(txtField.text ?? "0") ?? 0)
            txtField.text = String(result ?? 0)
        case "x":
            result = (result ?? 0) * (Float(txtField.text ?? "0") ?? 0)
            txtField.text = String(result ?? 0)
        case "/":
            result = (result ?? 0) / (Float(txtField.text ?? "0") ?? 0)
            txtField.text = String(result ?? 0)
        case "%":
            result = (result ?? 0) * ((Float(txtField.text ?? "0") ?? 0) / 100.0)
            txtField.text = String(result ?? 0)
        default:
            if firstTime {
                lastOperationPressed = operation
                firstTime = false
                result = (Float(txtField.text ?? "0"))
            }
            else {
                lastOperationPressed = ""
            }
        }
        
        lastOperationPressed = operation
    }
    
    func equalsPressed(){
        
        didPressOperation = false
        
        switch lastOperationPressed {
        case "+":
            result = (result ?? 0) + (Float(txtField.text ?? "0") ?? 0)
        case "-":
            result = (result ?? 0) - (Float(txtField.text ?? "0") ?? 0)
        case "x":
            result = (result ?? 0) * (Float(txtField.text ?? "0") ?? 0)
        case "/":
            result = (result ?? 0) / (Float(txtField.text ?? "0") ?? 0)
        case "%":
            result = (result ?? 0) * ((Float(txtField.text ?? "0") ?? 0) / 100.0)
        default:
            if lastOperationPressed == "" {
                result = Float(txtField.text ?? "0")
            }
        }
        
        lastOperationPressed = ""
        txtField.text = String(result ?? 0)
        
    }

    func clear() {
        txtField.text = ""
        result = 0
        didPressOperation = false
        lastOperationPressed = ""
        firstTime = true
    }
    
    func toggleNegativeNumber() {
        if txtField.text?.first == "-" {
            txtField.text?.removeFirst()
        }
        else {
            txtField.text = "-" + (txtField.text ?? "")
        }
    }
    
    func addPointForDecimal() {
        guard let textFieldText = txtField.text,
              textFieldText != "" || textFieldText != "0"
        else {
            txtField.text = "0."
            return
        }
        
        if !textFieldText.contains(".") {
            txtField.text = textFieldText + "."
        }
        
        return
        
    }
}
