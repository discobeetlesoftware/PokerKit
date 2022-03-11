//
//  Created on 7/28/16.
//

import Foundation

public enum Rank: Int {
    case invalid = -1
    case aceLow = 1
    case two = 2, three, four, five
    case six, seven, eight, nine, ten
    case jack, queen, king, ace
}


extension Rank: Comparable {}

public func <(lhs: Rank, rhs: Rank) -> Bool {
    return lhs.rawValue < rhs.rawValue
}


extension Rank: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalid: return "I"
        case .aceLow, .ace: return "A"
        case .jack: return "J"
        case .queen: return "Q"
        case .king: return "K"
        default:
            return "\(rawValue)"
        }
    }
}

