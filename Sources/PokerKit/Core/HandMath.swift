//
//  Created on 7/28/16.
//

import Foundation
//import Dollar

extension Hand: Comparable {}

public func ==(lhs: Hand, rhs: Hand) -> Bool {
    return lhs.allCards == rhs.allCards
}

public func <(lhs: Hand, rhs: Hand) -> Bool {
    if lhs.count == 0 && rhs.count == 0 {
        return true
    } else if rhs.count == 0 {
        return true
    } else if lhs.count == 0 {
        return false
    }
    var lCards = lhs.allCards, rCards = rhs.allCards
    var lCard:PlayingCard, rCard:PlayingCard
    repeat {
        lCard = lCards.removeFirst()
        rCard = rCards.removeFirst()
    } while (lCards.count > 0 && rCards.count > 0) && lCard.rank == rCard.rank
    return lCard.rank < rCard.rank
}

// MARK: - Arithmetic Operators

public func +(lhs: Hand, rhs: Hand) -> Hand {
    return Hand(lhs.allCards + rhs.allCards)
}

public func -(lhs: Hand, rhs: Hand) -> Hand {
    return Hand()
//    let difference = $.difference(lhs.allCards, rhs.allCards)
//    return Hand(difference)
}

public func +=(lhs:inout Hand, rhs:Hand) {
    lhs.allCards.append(contentsOf: rhs.allCards)
}

public func +=(lhs:inout Hand, rhs:PlayingCard) {
    lhs.allCards.append(rhs)
}

public func +(lhs: Hand, rhs: PlayingCard) -> Hand {
    return Hand(lhs.allCards + [rhs])
}

public func -(lhs: Hand, rhs: PlayingCard) -> Hand {
    return Hand()
//    let difference = $.difference(lhs.allCards, [rhs])
//    return Hand(difference)
}
