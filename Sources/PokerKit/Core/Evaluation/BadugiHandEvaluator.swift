//
//  Created on 4/8/17.
//

import Foundation

open class BadugiHandEvaluator: HandEvaluator {
    let configuration: HandEvaluatorConfiguration
    
    public required init(configuration: HandEvaluatorConfiguration) {
        self.configuration = configuration
    }
    
    public func evaluate(_ hand: Hand) -> HandEvaluationResult {
        let model = HandEvaluationModel(withCards: hand)
        let firstAceIndex = model.allCards.firstIndex(where: {$0.rank == .ace})
        var allCards = model.allCards
        if let index = firstAceIndex {
            let prefix = allCards.prefix(upTo: index)
            let suffix = allCards.suffix(from: index)
            allCards = Array(suffix + prefix)
        }
        
        let rankHand = allCards.reduce(Hand()) { hand, card in
            let hasSuit = hand.contains(where: { return $0.suit == card.suit })
            guard !hasSuit else { return hand }
            let hasRank = hand.contains(where: { return $0.rank == card.rank })
            guard !hasRank else { return hand }
            return hand + [card]
        }
        
        return HandEvaluationResult(rank: .badugi, hand: model, rankHand: rankHand, hasKickers: false)
    }
}
