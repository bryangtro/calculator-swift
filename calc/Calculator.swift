///
///  Created by Bryan Guntro on 04/03/2020.
///  Copyright © 2021 UTS. All rights reserved.
///  MIT License
///

import Foundation

class Calculator {
    
    var postfix = [String]()
    
    // Constructor when an object instance is created, taking an array of string as its parameter
    init (args: [String]) {
        // Convert Infix to Postfix
        postfix = generatePostfix(infix: args);
    }
    
    // This function converts the infix String array to postfix String array
    func generatePostfix(infix: [String]) -> [String] {
        var output_queue = Queue()
        var operator_stack = Stack()
        
        // Shunting Yard algorithm
        for element in infix {
            if (element.isInt) {
                output_queue.enqueue(element)
            } else {
                // If stack is not empty compare the current element with the stack's head precedence value
                if (!operator_stack.isEmpty) {
                    var topStackOperandVal = operator_stack.peek().getOperandPrecedanceValue
                    let currOperandVal = element.getOperandPrecedanceValue
                    
                    // Check if the operand of the top stack has a higher / equal precedance
                    while (!operator_stack.isEmpty && topStackOperandVal >= currOperandVal) {
                        // Enqueue the top stack and pop it
                        output_queue.enqueue(operator_stack.peek())
                        operator_stack.pop()
                        topStackOperandVal = operator_stack.peek().getOperandPrecedanceValue
                    }
                    operator_stack.push(element)
                } else {
                    operator_stack.push(element)
                }
                
            }
        }
        
        // Enqueue the remaining operator stack to the output queue
        while (!operator_stack.isEmpty) {
            output_queue.enqueue(operator_stack.peek())
            operator_stack.pop()
        }
        
        return output_queue.items
    }
    
    // Return the result if past Calculation Check
    func returnResult() -> Any {
        do {
            let result = try evaluatePostfix(postfix)
            return result
        } catch CalculatorError.invalidOperator(let unknownOperator) {
            print( "Error! Unknown Operator: \(unknownOperator)")
            exit(404)
        } catch CalculatorError.divisionByZero {
            print ("Error! Division By Zero.")
            exit(404)
        } catch CalculatorError.outOfBounds(let number1, let number2, let operand) {
            print("Error! Integer Overflow: \(number1) \(operand) \(number2) > \(Int.max)")
            exit(404)
        } catch {
            print ("Unexpected error: \(error)")
            exit(404)
        }
        
    }
    

    
    // This method evaluates the postfix epression using a stack from the given String array (queue)
    func evaluatePostfix(_ args: [String]) throws -> Int  {
        var number_stack = Stack()
        for element in args {
            var num1: Int?
            var num2: Int?
            if element.isInt {
                number_stack.push(element)
            } else {
                if (!number_stack.isEmpty){
                    num2 = Int(number_stack.pop()!);
                    num1 = Int(number_stack.pop()!);
                    
                    let number1 = num1!
                    let number2 = num2!
                    
                    // Handling the operand value and ensuring that the parsed result does not exceed Int 64 Bit Value
                    switch (element) {
                    case "+":
                        let (number, isOverflow) = number1.addingReportingOverflow(number2)
                        if (isOverflow) {
                            throw CalculatorError.outOfBounds(number1: num1!, number2: num2!, operand: element)
                        }
                        
                        number_stack.push(String(num1! + num2!))
                        
                    case "-":
                        let (number, isOverflow) = number1.subtractingReportingOverflow(number2)
                        if (isOverflow) {
                            throw CalculatorError.outOfBounds(number1: num1!, number2: num2!, operand: element)
                        }
                        
                        number_stack.push(String(num1! - num2!))
                        
                    case "x":
                        let (number, isOverflow)  = number1.multipliedReportingOverflow(by: number2)
                        if (isOverflow) {
                            throw CalculatorError.outOfBounds(number1: num1!, number2: num2!, operand: element)
                        }
                        
                        number_stack.push(String(num1! * num2!))
                        
                    case "/":
                        let (number, isOverflow)  = number1.dividedReportingOverflow(by: number2)
                        
                        // Division By Zero Error
                        if (num2! == 0) {
                            throw CalculatorError.divisionByZero
                        } else if (isOverflow) {
                            // Integer overflow error
                            throw CalculatorError.outOfBounds(number1: num1!, number2: num2!, operand: element)
                        }
                        
                        number_stack.push(String(num1! / num2!))
                        
                    case "%":
                        let (number, isOverflow) = number1.multipliedReportingOverflow(by: number2)
                        
                        // If modulus reminder exceed Int.max value
                        if (isOverflow) {
                            throw CalculatorError.outOfBounds(number1: num1!, number2: num2!, operand: element)
                        }
                        number_stack.push(String(num1! % num2!))
                    default:
                        throw CalculatorError.invalidOperator(element)
                    }
                }
                
            }
        }
        
        // The result of the postfix expression would be the last element in the stack
        // There WILL ALWAYS be one element left when evaluating a valid postfix equation / experession in all cases.
        let result = Int(number_stack.pop()!)
        return result!;
    }
    
}
