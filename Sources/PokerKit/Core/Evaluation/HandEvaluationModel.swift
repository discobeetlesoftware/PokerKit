//
//  Created on 4/1/17.
//

import Foundation

public struct HandEvaluationModel {
    static var configuration: HandEvaluatorConfiguration = DefaultConfiguration()
    var configuration: HandEvaluatorConfiguration { return HandEvaluationModel.configuration }
    
    var allCards: [PlayingCard] = [] {
        didSet {
            setup()
        }
    }
    var count: Int { return allCards.count }
    
    public var allCardsByRank: [Rank:Hand] = [:]
    public var allCardsBySuit: [Suit:Hand] = [:]
    public var allCardsBySequence: [Rank:Hand] = [:]
    
    public init(withCards cards: [PlayingCard]) {
        self.allCards = cards.sorted()
        setup()
    }

    public init(arrayLiteral elements: PlayingCard...) {
        self.allCards = elements.sorted()
        setup()
    }
    
    mutating func setup() {
        allCardsByRank = self.groupCards { $0.rank }
        allCardsBySuit = self.groupCards { $0.suit }
        allCardsBySequence = self.groupBySequence(maxSize: configuration.cardCount)
    }
    
    // Returns a dictionary of sequences keyed by the lowest rank in the sequence
    // Only sequences > 1 card are returned
    mutating func groupBySequence(maxSize: Int) -> [Rank:Hand] {
        func cardForRank(_ rank: Rank) -> PlayingCard? {
            let hand: Hand = allCardsByRank[rank] ?? []
            return hand.first
        }
        
        func appendSequence(_ dict: inout [Rank:Hand], _ hand: inout Hand) {
            if hand.count > 1 {
                let sequenceRank = hand[0].rank
                dict[sequenceRank] = hand
            }
        }
        
        typealias SequenceAccumulator = (hand: Hand, hasSequence: Bool)
        var accumulator: SequenceAccumulator = SequenceAccumulator([], false)
        var sequences: [Rank:Hand] = self.allRanks().reduce([:]) { dict, rank in
            var dict = dict
            let maybeCard = cardForRank(rank)
            let hasCardInSequence = maybeCard != nil
            if accumulator.hasSequence, let card = maybeCard {
                let aleadyAtMax = accumulator.hand.count == maxSize
                if aleadyAtMax {
                    appendSequence(&dict, &accumulator.hand)
                    accumulator.hand.removeFirst()
                }
                accumulator.hand += [card]
            } else if hasCardInSequence {
                accumulator.hand = [maybeCard!]
                accumulator.hasSequence = true
            } else if accumulator.hasSequence {
                appendSequence(&dict, &accumulator.hand)
                accumulator.hasSequence = false
            }
            return dict
        }
        appendSequence(&sequences, &accumulator.hand)
        return sequences
    }
}

extension HandEvaluationModel {
    func groupCards<U: Hashable>(_ callback: (PlayingCard) -> U) -> [U: Hand] {
        var grouped = [U: Hand]()
        for element in allCards {
            let key = callback(element)
            if let hand = grouped[key] {
                let newHand = hand + [element]
                grouped[key] = newHand
            } else {
                grouped[key] = [element]
            }
        }
        return grouped
    }
    
    static let ranks: [Rank] = [ .two, .three, .four, .five,
                                 .six, .seven,.eight, .nine,
                                 .ten, .jack, .queen, .king, .ace ]
    func allRanks() -> [Rank] {
        if HandEvaluationModel.configuration.isAceLow {
            return [ .ace ] + HandEvaluationModel.ranks
        } else {
            return HandEvaluationModel.ranks
        }
    }
}

extension HandEvaluationModel: CustomStringConvertible {
    public var description: String {
        return allCards.prettyDescription()
    }
}
