//
//  Created on 7/28/16.
//

public protocol HandEvaluatorSchema {
    // Number of decks being used
    var decksCount: Int { get }

    // Number of cards to qualify for low hand
    var cardCount: Int { get }

    // The highest card which can participate in a low hand
    var qualifyingRank: Rank { get set }

    // Indicates if the ace has a low rank as well as high
    var isAceLow: Bool { get set }

    // A white-list of high-hands which are disallowed in a qualifying low
    var invalidHandRanks: [HandRank]? { get set }
}

public struct DefaultSchema : HandEvaluatorSchema {
    public var decksCount = 1
    public var cardCount = 5
    public var qualifyingRank = Rank.ace
    public var isAceLow = true
    public var invalidHandRanks:[HandRank]? = [ HandRank.pair ]
}
