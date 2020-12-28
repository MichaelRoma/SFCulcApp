//
//  ViewController.swift
//  CulcApp
//
//  Created by Mykhailo Romanovskyi on 21.12.2020.

//  Цифры с 0 по 9 включительно имеют tag с 0 по 9 соответственно!!!
//  Точка будет иметь tag 10!!!
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var screenLabel: UILabel!
    @IBOutlet var serviceButtons: [UIButton]!
    
    private var bufferText = ""
    private var firstOperand = ""
    
    private var selectedAction: MathActions? = nil
    
    private enum MathActions {
        case plus
        case minus
        case divide
        case multiply
        case squarRoot
        case exponentiation
        case percent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSomeElementsSettings()
    }
    
    @IBAction func ninePressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    @IBAction func eightPressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    @IBAction func sevenPressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    @IBAction func sixPressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    @IBAction func fivePressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    @IBAction func fourPressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    @IBAction func threePressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    @IBAction func twoPressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    @IBAction func onePressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    @IBAction func zeroPressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        actionForScreen(tag: sender.tag)
    }
    
    // MARK: complex math actions
    @IBAction func sqrtButtonPressed(_ sender: UIButton) {
        guard let number = Double(bufferText) else { return }
        let result = sqrt(number)
        screenLabel.text = modf(result).1 == 0 ? "\(Int(result))" : String(format: "%.02f", result)
        clearAll()
    }
    
    @IBAction func powButtonPressed(_ sender: UIButton) {
        mathActions(action: .exponentiation, sender: sender)
    }
    
    @IBAction func precentButtonPressed(_ sender: UIButton) {
        mathActions(action: .percent, sender: sender)
    }
    
    
    @IBAction func minusPlusButtonPressed(_ sender: UIButton) {
        guard let number = Double(bufferText) else { return }
        if number > 0 {
            bufferText = "\(-number)"
            screenLabel.text = modf(number).1 == 0 ? "\(Int(-number))" : "\(-number)"
        } else {
            bufferText = "\(-1 * number)"
            screenLabel.text = modf(number).1 == 0 ? "\(Int(-1 * number))" : "\(-1 * number)"
        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        clearAll()
        screenLabel.text = "0"
    }
    
    @IBAction func deleteLastsymbol(_ sender: Any) {
        if bufferText.count == 1 {
            bufferText.removeLast()
            screenLabel.text = "0"
        } else if bufferText.count > 0 {
            bufferText.removeLast()
            screenLabel.text = bufferText
        }
    }
    
    // MARK: arithmetic operations
    @IBAction func divideButtonPressed(_ sender: UIButton) {
        mathActions(action: .divide, sender: sender)
    }
    
    @IBAction func multiplyButtonPressed(_ sender: UIButton) {
        mathActions(action: .multiply, sender: sender)
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        mathActions(action: .minus, sender: sender)
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        mathActions(action: .plus, sender: sender)
    }
    
    // MARK: Result Action
    @IBAction func resultButtonPressed(_ sender: UIButton) {
        switch selectedAction {
        case .divide:
            let fOper = Double(firstOperand) ?? 0
            let sOper = Double(bufferText) ?? 0
            if sOper == 0 {
                screenLabel.text = "Нелья делить на ноль"
                return
            }
            let result = fOper / sOper
            screenLabel.text = modf(result).1 == 0 ? "\(Int(result))" : "\(result)"
            clearAll()
        case .multiply:
            let fOper = Double(firstOperand) ?? 0
            let sOper = Double(bufferText) ?? 0
            let result = fOper * sOper
            screenLabel.text = modf(result).1 == 0 ? "\(Int(result))" : "\(result)"
            clearAll()
        case .minus:
            let fOper = Double(firstOperand) ?? 0
            let sOper = Double(bufferText) ?? 0
            let result = fOper - sOper
            screenLabel.text = modf(result).1 == 0 ? "\(Int(result))" : "\(result)"
            clearAll()
        case .plus:
            let fOper = Double(firstOperand) ?? 0
            let sOper = Double(bufferText) ?? 0
            let result = fOper + sOper
            screenLabel.text = modf(result).1 == 0 ? "\(Int(result))" : "\(result)"
            clearAll()
            
        case .exponentiation:
            let fOper = Float(firstOperand) ?? 0
            let sOper = Float(bufferText) ?? 0
            let result = pow(fOper, sOper)
            screenLabel.text = modf(result).1 == 0 ? "\(Int(result))" : "\(result)"
            clearAll()
            
        case .percent:
            let fOper = Float(firstOperand) ?? 0
            let sOper = Float(bufferText) ?? 0
            let result = fOper * (sOper / 100)
            screenLabel.text = modf(result).1 == 0 ? "\(Int(result))" : "\(result)"
            clearAll()
        default:
            return
        }
    }
}

// MARK: Extionsion for private methods

extension ViewController {
    
    private func mathActions(action: MathActions, sender: UIButton) {
        if selectedAction != nil { return }
        sender.layer.opacity = 0.5
        selectedAction = action
        firstOperand = bufferText
        bufferText = ""
    }
    
    private func clearAll() {
        selectedAction = nil
        firstOperand = ""
        bufferText = ""
        for button in serviceButtons {
            button.layer.opacity = 1
        }
    }
    
    private func actionForScreen(tag: Int) {
        
        //Ограничение по количеству символов
        if bufferText.count == 9 { return }
        if tag == 10 {
            if bufferText.contains(".") { return }
            bufferText += bufferText.count == 0 ? "0." : "."
            screenLabel.text = bufferText
            return
        }
        
        bufferText += "\(tag)"
        screenLabel.text = bufferText
    }
    
    private func setupSomeElementsSettings() {
        for button in serviceButtons {
            let image = button.image(for: .normal)
            let highlighted = image?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray)
            button.setImage(highlighted, for: .highlighted)
        }
    }
}
