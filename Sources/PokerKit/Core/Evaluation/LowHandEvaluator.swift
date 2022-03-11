//
//  Created on 7/28/16.
//

public class LowHandEvaluator: HandEvaluator {
    let configuration: HandEvaluatorConfiguration
    
    public required init(configuration: HandEvaluatorConfiguration) {
        self.configuration = configuration
    }
    
    /*
    public func evaluateHand(_ hand: Hand) -> [HandEvaluationResult] {
        let model = HandEvaluationModel(withCards: hand)
        let cards = getCards(model)
        let match: [PlayingCard] = cards.reduce([PlayingCard]()) { currentCards, lowCard in
            let list = currentCards + [lowCard]
            let invalidated = self.isHighHandInvalidated(list, model.schema)
            return invalidated ? currentCards : list
        }
        
        if match.count < model.schema.cardCount {
            return [HandEvaluationResult(rank: HandRank.invalid, primary: Hand(match), kickers: nil)]
        } else {
            let elements = Hand(Array(match.prefix(model.schema.cardCount)))
            return [HandEvaluationResult(rank: .low, hand: model, rankHand: elements, hasKickers: false)]
        }
    }
*/
    open func isHighHandInvalidated(_ hand: Hand, _ configuration: HandEvaluatorConfiguration) -> Bool {
        guard let invalidRanks = configuration.invalidHandRanks else { return false }
        var highConfiguration = DefaultConfiguration()
        highConfiguration.cardCount = configuration.cardCount
        highConfiguration.isAceLow = true
        let high = HighHandEvaluator(configuration: highConfiguration)
        let hands = high.evaluateHand(hand)
        if hands == [ HandEvaluationResult(rank: HandRank.highCard, primary: nil, kickers: nil) ] {
            return false
        }
        let invalidHands = hands.filter { invalidRanks.contains($0.rank!) }
        return invalidHands.count > 0
    }

    func getCards(_ hand: HandEvaluationModel) -> [PlayingCard] {
        let cards = hand.allCards.compactMap({ $0 }).sorted(by: <)

        let lastRank = cards.last?.rank
        let initial: [PlayingCard]
        if self.configuration.isAceLow && lastRank == .ace {
            initial = [ cards.last! ]
        } else {
            initial = []
        }

        return cards.reduce(into: initial) { sum, nextCard in
            if nextCard.rank <= self.configuration.qualifyingRank {
                sum.append(nextCard)
            }
        }
    }
    
    public func evaluate(_ hand: Hand) -> HandEvaluationResult {
        let model = HandEvaluationModel(withCards: hand)
        let cards = getCards(model)
        let match: [PlayingCard] = cards.reduce([PlayingCard]()) { currentCards, lowCard in
            let list = currentCards + [lowCard]
            let invalidated = self.isHighHandInvalidated(list, model.configuration)
            return invalidated ? currentCards : list
        }
        
        if match.count < model.configuration.cardCount {
            return HandEvaluationResult(rank: HandRank.invalid, primary: Hand(match), kickers: nil)
        } else {
            let elements = Hand(Array(match.prefix(model.configuration.cardCount)))
            //               let kickers:Hand? = Hand(cards) - elements
            return HandEvaluationResult(rank: HandRank.low, primary: elements, kickers: nil)
        }
    }
}
