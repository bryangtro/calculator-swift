///
///  Created by Bryan Guntro on 04/03/2020.
///  Copyright © 2021 UTS. All rights reserved.
///  MIT License
///

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

enum CalculatorError: Error {
    case invalidInput
    case divisionByZero
    case invalidNumber(_: String)
    case invalidOperator (_: String)
    case outOfBounds (number1: Int, number2: Int, operand: String)
    case numberOverflow(_: String)
}

do {
    try ExceptionHandler().checkInput(args)
    
    // Initialize a Calculator object
    let result = Calculator(args: args).returnResult()
    print(result)
    
} catch CalculatorError.invalidInput {
    print("Error! Incomplete expression: Expected input of the form [number] [operator number ...]")
    exit(404)
} catch CalculatorError.invalidNumber(let number) {
    print("Error! Invalid number: \(number)")
    exit(404)
} catch CalculatorError.invalidOperator(let number) {
    print("Error! Unknown operator: \(number)")
    exit(404)
} catch CalculatorError.numberOverflow(let number) {
    print("Error! Out of Bounds Integer: \(number)")
    exit(404)
}


