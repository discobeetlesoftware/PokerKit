//
//  Created on 7/28/16.
//

public struct PlayingCard: Hashable {
    public let rank: Rank
    public let suit: Suit

    public init(rank: Rank, suit: Suit) {
        self.rank = rank
        self.suit = suit
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rank)
        hasher.combine(suit)
    }
}


extension PlayingCard: Equatable {}

public func ==(lhs: PlayingCard, rhs: PlayingCard) -> Bool {
    return lhs.rank == rhs.rank && lhs.suit == rhs.suit
}


extension PlayingCard: Comparable {}

public func <(lhs: PlayingCard, rhs: PlayingCard) -> Bool {
    return lhs.rank == rhs.rank ? lhs.suit < rhs.suit : lhs.rank < rhs.rank
}


extension PlayingCard: CustomStringConvertible {
    public var description: String {
        return "\(rank)\(suit)"
    }
}
