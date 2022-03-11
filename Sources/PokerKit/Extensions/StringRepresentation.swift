//
//  Created on 7/28/16.
//

import Foundation

extension Suit: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        let lowercaseValue = value.lowercased()
        switch lowercaseValue {
        case "s": self = .spades
        case "h": self = .hearts
        case "d": self = .diamonds
        case "c": self = .clubs
        default: self = .invalid
        }
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

extension Rank: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        let lowercaseValue = value.lowercased()
        switch lowercaseValue {
        case "1": self = .aceLow
        case "2": self = .two
        case "3": self = .three
        case "4": self = .four
        case "5": self = .five
        case "6": self = .six
        case "7": self = .seven
        case "8": self = .eight
        case "9": self = .nine
        case "t": self = .ten
        case "j": self = .jack
        case "q": self = .queen
        case "k": self = .king
        case "a": self = .ace
        default: self = .invalid
        }
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

extension PlayingCard: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    static public func hand(_ value: String) -> [PlayingCard] {
        var result = [PlayingCard]()
        var literal = ""
        value.forEach { char in
            if (char != " ") {
                literal.append(char)
                if literal.count == 2 {
                    result.append(PlayingCard(stringLiteral: literal))
                    literal = ""
                }
            }
        }
        return result
    }
    
    public init(stringLiteral value: String) {
        if value.count == 2 {
            let rank: Rank = Rank(stringLiteral: String(value.first!))
            let suit: Suit = Suit(stringLiteral: String(value.last!))
            self = PlayingCard(rank: rank, suit: suit)
        } else {
            self = PlayingCard(rank: Rank.invalid, suit: Suit.invalid)
        }
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}
