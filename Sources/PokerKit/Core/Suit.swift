//
//  Created on 7/28/16.
//

import Foundation

public enum Suit: Int {
    case invalid = -1
    case spades = 0, hearts, diamonds, clubs
}


extension Suit: Comparable {}

public func <(lhs: Suit, rhs: Suit) -> Bool {
    return lhs.rawValue < rhs.rawValue
}


extension Suit: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalid: return "I"
        case .spades: return "♠︎"
        case .hearts: return "♡"
        case .diamonds: return "♢"
        case .clubs: return "♣︎"
        }
    }
}
