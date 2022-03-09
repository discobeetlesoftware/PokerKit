//
//  Created on 8/11/16.
//

import Foundation

// MARK: - Comparable

extension NSDecimalNumber: Comparable {}

public func ==(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedSame
}

public func <(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .orderedAscending
}

// MARK: - Arithmetic Operators

public prefix func -(value: NSDecimalNumber) -> NSDecimalNumber {
    return value.multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
}

public func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.adding(rhs)
}

public func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.subtracting(rhs)
}

public func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.multiplying(by: rhs)
}

public func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.dividing(by: rhs)
}

public func ^(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.raising(toPower: rhs)
}

public func +(lhs: NSDecimalNumber, rhs: String) -> NSDecimalNumber {
    return lhs + NSDecimalNumber(string: rhs)
}

public func -(lhs: NSDecimalNumber, rhs: String) -> NSDecimalNumber {
    return lhs - NSDecimalNumber(string: rhs)
}

public func *(lhs: NSDecimalNumber, rhs: String) -> NSDecimalNumber {
    return lhs * NSDecimalNumber(string: rhs)
}

public func /(lhs: NSDecimalNumber, rhs: String) -> NSDecimalNumber {
    return lhs / NSDecimalNumber(string: rhs)
}
