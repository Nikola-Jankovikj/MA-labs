//
//  CalculatorView.swift
//  CalculatorSwiftUI
//
//  Created by Nikola Jankovikj on 27.12.24.
//

import SwiftUI

struct CalculatorView: View {
    @State private var display = "0"
    @State private var currentNumber = ""
    @State private var previousNumber: Double? = nil
    @State private var currentOperation: Operation? = nil

    enum Operation {
        case add, subtract, multiply, divide

        func compute(_ a: Double, _ b: Double) -> Double {
            switch self {
            case .add: return a + b
            case .subtract: return a - b
            case .multiply: return a * b
            case .divide: return a / b
            }
        }
    }

    let buttons: [[String]] = [
        ["C", "+/-", "%", "/"],
        ["7", "8", "9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "=", ""]
    ]

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Spacer()
                Text(display)
                    .font(.largeTitle)
                    .padding()
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }

            drawButtons(buttons: buttons)
        }
        .padding()
    }
    
    @ViewBuilder
    func drawButtons(buttons: [[String]]) -> some View {
        ForEach(buttons, id: \.[0]) { row in
            HStack {
                drawButtonsInner(row: row)
            }
        }
    }
    
    @ViewBuilder
    func drawButtonsInner(row: [String]) -> some View {
        ForEach(row, id: \.self) { button in
            drawButton(button: button)
        }
    }
    
    @ViewBuilder
    func drawButton(button: String) -> some View {
        if button != "" {
            Button(action: { self.buttonTapped(button) }) {
                Text(button)
                    .font(.title)
                    .frame(width: self.buttonWidth(button), height: self.buttonHeight())
                    .background(self.buttonColor(button))
                    .foregroundColor(.white)
                    .cornerRadius(self.buttonWidth(button) / 2)
            }
        }
    }

    func buttonTapped(_ button: String) {
        switch button {
        case "0"..."9":
            if currentNumber == "0" || display == "0" {
                currentNumber = button
            } else {
                currentNumber += button
            }
            display = currentNumber
        case ".":
            if !currentNumber.contains(".") {
                currentNumber += "."
                display = currentNumber
            }
        case "+", "-", "x", "/":
            if let num = Double(currentNumber) {
                previousNumber = num
                currentNumber = ""

                switch button {
                case "+": currentOperation = .add
                case "-": currentOperation = .subtract
                case "x": currentOperation = .multiply
                case "/": currentOperation = .divide
                default: break
                }
            }
        case "=":
            if let operation = currentOperation, let num = Double(currentNumber), let prev = previousNumber {
                let result = operation.compute(prev, num)
                display = String(result)
                currentNumber = display
                previousNumber = nil
                currentOperation = nil
            }
        case "C":
            display = "0"
            currentNumber = ""
            previousNumber = nil
            currentOperation = nil
        case "+/-":
            if let num = Double(currentNumber) {
                currentNumber = String(-num)
                display = currentNumber
            }
        case "%":
            if let num = Double(currentNumber) {
                currentNumber = String(num / 100)
                display = currentNumber
            }
        default:
            break
        }
    }

    func buttonWidth(_ button: String) -> CGFloat {
        return button == "0" ? (UIScreen.main.bounds.width - 50) / 2 : (UIScreen.main.bounds.width - 60) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 60) / 4
    }

    func buttonColor(_ button: String) -> Color {
        switch button {
        case "+", "-", "x", "/", "=": return .orange
        case "C", "+/-", "%": return .gray
        default: return .blue
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

