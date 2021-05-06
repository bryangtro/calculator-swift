///
///  Stack Implementation with O(n) runtime
///
///  Created by Bryan Guntro on 04/03/2020.
///  Copyright © 2021 UTS. All rights reserved.
///  MIT License
///

import Foundation

struct Stack {
    var myArray: [String] = []
    var isEmpty : Bool { return myArray.isEmpty }
    
    mutating func push(_ element: String) {
        myArray.append(element)
    }
    
    mutating func pop() -> String? {
        return myArray.popLast()
    }
    
    func peek() -> String {
        guard let topElement = myArray.last else {return ""}
        return topElement
    }
}
