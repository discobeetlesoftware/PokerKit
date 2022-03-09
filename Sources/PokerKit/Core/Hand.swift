//
//  Created on 7/28/16.
//

public final class Hand : ExpressibleByArrayLiteral {
    public typealias Element = PlayingCard

    var schema: HandEvaluatorSchema = DefaultSchema()

    var allCards: [PlayingCard] = []

    var count: Int { return allCards.count }

    var _allCardsByRank: [Rank:Hand]?
    public var allCardsByRank: [Rank:Hand] {
        get {
            return Global.lazyInit(&_allCardsByRank) { return self.groupCards { $0.rank } }
        }
    }

    var _allCardsBySuit: [Suit:Hand]?
    public var allCardsBySuit: [Suit:Hand] {
        get {
            return Global.lazyInit(&_allCardsBySuit) { return self.groupCards { $0.suit } }
        }
    }

    var _allCardsBySequence: [Rank:Hand]?
    public var allCardsBySequence: [Rank:Hand] {
        get {
            return Global.lazyInit(&_allCardsBySequence) { return self.groupBySequence() }
        }
    }

    public subscript(n: Int) -> Element? {
        get {
            if n < self.allCards.count {
                return allCards[n]
            } else {
                return nil
            }
        }
        set {
            if let element = newValue {
                allCards[n] = element
            } else {
                allCards.remove(at: n)
            }
            self.reset()
        }
    }

    public init(_ allCards: [PlayingCard]) {
        self.allCards = allCards
    }

    public required init(arrayLiteral elements: PlayingCard...) {
        self.allCards = elements
    }

    func reset() {
        _allCardsByRank = nil
        _allCardsBySuit = nil
        _allCardsBySequence = nil
    }

    // Returns a dictionary of sequences keyed by the lowest rank in the sequence
    // Only sequences > 1 card are returned
    func groupBySequence() -> [Rank:Hand] {
        func cardForRank(_ rank:Rank) -> PlayingCard? {
            let hand: Hand = allCardsByRank[rank] ?? []
            return hand[0]
        }
        func appendSequence(_ dict: inout [Rank:Hand], _ hand: inout Hand) {
            if hand.count > 1 {
                let sequenceRank = hand[0]!.rank
                dict[sequenceRank] = hand
            }
        }
        typealias Accumulator = (hand: Hand, hasSequence: Bool)
        var accumulator: Accumulator = Accumulator([], false)
        var sequences: [Rank:Hand] = allRanks().reduce([:]) { dict, rank in
            var dict = dict
            let maybeCard = cardForRank(rank)
            let hasCard = maybeCard != nil
            if hasCard && accumulator.hasSequence {
                accumulator.hand += maybeCard!
            } else if hasCard {
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

extension Hand { // Helpers
    func groupCards<U: Hashable>(_ callback: (PlayingCard) -> U) -> [U: Hand] {
        var grouped = [U: Hand]()
        for element in allCards {
            let key = callback(element)
            if let hand = grouped[key] {
                hand.allCards.append(element)
                grouped[key] = hand
            } else {
                grouped[key] = [element]
            }
        }
        return grouped
    }

    static let ranks: [Rank] = [ .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king, .ace ]
    func allRanks() -> [Rank] {
        if self.schema.isAceLow {
            return [ .ace ] + Hand.ranks
        } else {
            return Hand.ranks
        }
    }
}

extension Hand: CustomStringConvertible {
    public var description: String {
        return allCards.prettyDescription()
    }
}
