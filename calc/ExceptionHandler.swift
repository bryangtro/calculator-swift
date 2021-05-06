///
///  Input Error Handling
///
///  Created by Bryan Guntoro on 7/3/21.
///  Copyright © 2021 UTS. All rights reserved.
///  MIT License
///

import Foundation

struct ExceptionHandler {
    
    func checkInput(_ args: [String]) throws {
        // If expression is not composed of [number] [operator] [number] - A complete valid equation array's size should be an odd number.
        if (args.count % 2 == 0) {
            throw CalculatorError.invalidInput
        }
        
        for i in stride(from: 0, to: args.count, by: 2) {
            guard let floatedStr = args[i].getFloat  else {
                // If string cannot be converted to float, which means it is not a number
                throw CalculatorError.invalidNumber(args[i])
            }
            
            if (floatedStr > Float(Int.max)) {
                throw CalculatorError.numberOverflow(args[i])
            }
        }
        
        for i in stride(from: 1, to: args.count, by: 2) {
            if (!args[i].isOperator) {
                throw CalculatorError.invalidOperator(args[i])
            }
        }
        
    }
}

