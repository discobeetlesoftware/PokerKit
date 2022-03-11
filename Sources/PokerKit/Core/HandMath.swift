//
//  Created on 7/28/16.
//

import Foundation

extension Hand: Comparable {}

public func <(lhs: Hand, rhs: Hand) -> Bool {
    if lhs.count == 0 && rhs.count == 0 {
        return true
    } else if rhs.count == 0 {
        return true
    } else if lhs.count == 0 {
        return false
    }
    var lCards = lhs, rCards = rhs
    var lCard: PlayingCard, rCard: PlayingCard
    repeat {
        lCard = lCards.removeFirst()
        rCard = rCards.removeFirst()
    } while (lCards.count > 0 && rCards.count > 0) && lCard.rank == rCard.rank
    return lCard.rank < rCard.rank
}

// MARK: - Arithmetic Operators

public func -(lhs: Hand, rhs: Hand) -> Hand {
    var result = lhs
    result.removeAll(where: { rhs.contains($0)})
    return result
}

public func +=(lhs: inout Hand, rhs: Hand) {
    lhs.append(contentsOf: rhs)
}

public func +=(lhs: inout Hand, rhs: PlayingCard) {
    lhs.append(rhs)
}

public func +(lhs: Hand, rhs: PlayingCard) -> Hand {
    return Hand(lhs + [rhs])
}

public func -(lhs: Hand, rhs: PlayingCard) -> Hand {
    return lhs - [rhs]
}
