//
//  Created on 7/28/16.
//

public enum HandRank: Int {
    case invalid, low
    case highCard, pair, twoPair, threeOfKind
    case straight, flush, fullHouse, fourOfKind, straightFlush, fiveOfKind

    public static func all() -> [HandRank] {
        var n = 0
        var list: [HandRank] = []
        while let rank = HandRank(rawValue: n) {
            list.append(rank)
            n += 1
        }
        return list
    }
}

extension HandRank: Equatable {}

public func ==(lhs: HandRank, rhs: HandRank) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

extension HandRank: Comparable {}

public func <(lhs: HandRank, rhs: HandRank) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

extension HandRank: CustomStringConvertible {
    public var description: String {
        switch(self) {
        case .invalid: return "invalid"
        case .low: return "low"
        case .highCard: return "high"
        case .pair: return "pair"
        case .twoPair: return "two pair"
        case .threeOfKind: return "trips"
        case .straight: return "straight"
        case .flush: return "flush"
        case .fullHouse: return "full house"
        case .fourOfKind: return "quads"
        case .straightFlush: return "straight flush"
        case .fiveOfKind: return "five of a kind"
        }
    }
}
