//
//  Created on 7/28/16.
//

import Foundation

extension HandEvaluationModel: Comparable {}

public func ==(lhs: HandEvaluationModel, rhs: HandEvaluationModel) -> Bool {
    return lhs.allCards == rhs.allCards
}

public func <(lhs: HandEvaluationModel, rhs: HandEvaluationModel) -> Bool {
    if lhs.count == 0 && rhs.count == 0 {
        return true
    } else if rhs.count == 0 {
        return true
    } else if lhs.count == 0 {
        return false
    }
    var lCards = lhs.allCards, rCards = rhs.allCards
    var lCard: PlayingCard, rCard: PlayingCard
    repeat {
        lCard = lCards.removeFirst()
        rCard = rCards.removeFirst()
    } while (lCards.count > 0 && rCards.count > 0) && lCard.rank == rCard.rank
    return lCard.rank < rCard.rank
}

// MARK: - Arithmetic Operators

func +(lhs: HandEvaluationModel, rhs: HandEvaluationModel) -> HandEvaluationModel {
    return HandEvaluationModel(withCards: lhs.allCards + rhs.allCards)
}

func -(lhs: HandEvaluationModel, rhs: HandEvaluationModel) -> HandEvaluationModel {
    let difference = lhs.allCards - rhs.allCards
    return HandEvaluationModel(withCards: difference)
}

func +=(lhs: inout HandEvaluationModel, rhs: HandEvaluationModel) {
    lhs.allCards = (lhs.allCards + rhs.allCards).sorted()
}

func +=(lhs: inout HandEvaluationModel, rhs: PlayingCard) {
    lhs.allCards = (lhs.allCards + [rhs]).sorted()
}

func +(lhs: HandEvaluationModel, rhs: PlayingCard) -> HandEvaluationModel {
    return HandEvaluationModel(withCards: Array( lhs.allCards + [rhs]))
}

func -(lhs: HandEvaluationModel, rhs: PlayingCard) -> HandEvaluationModel {
    let difference = lhs.allCards - [rhs]
    return HandEvaluationModel(withCards: difference)
}
