///
///  Queue Implementation with O(n) runtime
///
///  Created by Bryan Guntro on 04/03/2020.
///  Copyright © 2021 UTS. All rights reserved.
///  MIT License
///

import Foundation

struct Queue{
    var items:[String] = []
    
    mutating func enqueue(_ element: String) {
        items.append(element)
    }
    
    mutating func dequeue() -> String?{
        if items.isEmpty {
            return nil
        } else {
            let tempElement = items.first
            items.remove(at: 0)
            return tempElement
        }
    }
    
}
