//
//  Created on 7/28/16.
//


open class LowHandEvaluator : HandEvaluator {

    open func evaluateHand(_ hand: Hand) -> [HandEvaluationResult] {
        return []
    }

    open func isHighHandInvalidated(_ cards:[PlayingCard]) -> Bool {
        guard let invalidRanks = Hand().schema.invalidHandRanks else { return false }
        let high = HighHandEvaluator()
        let hands = high.evaluateHand(Hand(cards.flatMap({ $0 })))
        if hands == [ HandEvaluationResult(rank: HandRank.highCard, primary: nil, kickers: nil) ] {
            return false
        }
        let invalidHands = hands.filter { invalidRanks.contains($0.rank!) }
        return invalidHands.count > 0
    }

    func getCards(_ hand: Hand) -> [PlayingCard] {
        let cards = hand.allCards.flatMap({ $0 }).sorted(by: <)

        let lastRank = cards.last?.rank
        let initial: [PlayingCard]
        if hand.schema.isAceLow && lastRank == .ace {
            initial = [ cards.last! ]
        } else {
            initial = []
        }

        return cards.reduce(initial) { sum, nextCard in
            if nextCard.rank <= hand.schema.qualifyingRank {
                return sum + [nextCard]
            } else {
                return sum
            }
        }
    }

    open func evaluateHands(_ hands: [Hand]) -> [HandEvaluationResult] {
        return hands.map({ hand in
            let cards = getCards(hand)
            let match:[PlayingCard] = cards.reduce([PlayingCard]()) { currentCards, lowCard in
                let list = currentCards + [lowCard]
                let invalidated = self.isHighHandInvalidated(list)
                return invalidated ? currentCards : list
            }

            if match.count < hand.schema.cardCount {
                return HandEvaluationResult(rank: HandRank.invalid, primary: Hand(match), kickers: nil)
            } else {
                let elements = Hand(Array(match.prefix(hand.schema.cardCount)))
                let kickers:Hand? = Hand(cards) - elements
                return HandEvaluationResult(rank: HandRank.low, primary: elements, kickers: kickers)
            }
        })
    }
}
