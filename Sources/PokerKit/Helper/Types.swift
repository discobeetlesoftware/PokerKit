//
//  Created on 8/14/16.
//

import Foundation

public typealias Currency = NSDecimalNumber
public typealias VoidBlock = (() -> Void)

public func random(_ max:Int = 1) -> Int {
    return Int(arc4random_uniform(UInt32(max)))
}

// Returns nil if the provided optional is nil
// else Returns the result of calling the closure with not-nil
infix operator ~> : DefaultPrecedence

func ~><Input, Output>(optional: Input?, closure: (Input) -> Output?) -> Output? {
    guard let value = optional else { return nil }
    return closure(value)
}
