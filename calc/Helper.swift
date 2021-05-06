///
///  This swift file contain global helper methods that can be utilised within the scope to ensure loosely coupling
///
///  Created by Bryan Guntoro on 6/3/21.
///  Copyright © 2021 UTS. All rights reserved.
///  MIT License
///

import Foundation

extension String {
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    var getFloat: Float? {
        return Float(self)
    }
    
    var getOperandPrecedanceValue: Int {
        switch (self) {
        case "+", "-":
            return 1;
        case "/", "%", "x":
            return 2;
        default:
            return 0;
        }
    }
    
    var isOperator: Bool {
        switch (self) {
        case "+", "-", "/", "%", "x":
            return true
        default:
            return false
        }
    }
    
}



