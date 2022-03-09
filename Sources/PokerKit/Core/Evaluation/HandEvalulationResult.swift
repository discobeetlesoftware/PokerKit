//
//  Created on 8/10/16.
//

public struct HandEvaluationResult {
    public var rank:HandRank?
    public var primary:Hand?
    public var kickers:Hand?
}

extension HandEvaluationResult {
    static fileprivate func newMatchingAny(_ rank:HandRank) -> HandEvaluationResult {
        return HandEvaluationResult(rank: rank, primary: nil, kickers: nil)
    }
    static let invalid = HandEvaluationResult.newMatchingAny(.invalid)
    static let low = HandEvaluationResult.newMatchingAny(.low)
    static let highCard = HandEvaluationResult.newMatchingAny(.highCard)
    static let pair = HandEvaluationResult.newMatchingAny(.pair)
    static let twoPair = HandEvaluationResult.newMatchingAny(.twoPair)
    static let threeOfKind = HandEvaluationResult.newMatchingAny(.threeOfKind)
    static let straight = HandEvaluationResult.newMatchingAny(.straight)
    static let flush = HandEvaluationResult.newMatchingAny(.flush)
    static let fullHouse = HandEvaluationResult.newMatchingAny(.fullHouse)
    static let fourOfKind = HandEvaluationResult.newMatchingAny(.fourOfKind)
    static let straightFlush = HandEvaluationResult.newMatchingAny(.straightFlush)
    static let fiveOfKind = HandEvaluationResult.newMatchingAny(.fiveOfKind)
}

extension HandEvaluationResult : Equatable {}

public func ==(lhs: HandEvaluationResult, rhs: HandEvaluationResult) -> Bool {
    let (lRank, rRank) = (lhs.rank, rhs.rank)
    if equalWild(lRank, rRank) { return true }
    if lRank! != rRank! { return false }

    let (lPrimary, rPrimary) = (lhs.primary, rhs.primary)
    if equalWild(lPrimary, rPrimary) { return true }
    if lPrimary! != rPrimary! { return false }

    let (lKickers, rKickers) = (lhs.kickers, rhs.kickers)
    if equalWild(lKickers, rKickers) { return true }
    return lKickers! == rKickers!
}

extension HandEvaluationResult : Comparable {}

public func <(lhs: HandEvaluationResult, rhs: HandEvaluationResult) -> Bool {
    let ltRank = lessThanWild(lhs.rank, rhs.rank)
    if ltRank.hasResult { return ltRank.result }
    let (lRank, rRank) = (lhs.rank!, rhs.rank!)
    if lRank != rRank { return lRank < rRank }

    let ltPrimary = lessThanWild(lhs.primary, rhs.primary)
    if ltPrimary.hasResult { return ltPrimary.result }
    let (lPrimary, rPrimary) = (lhs.primary!, rhs.primary!)
    if lPrimary != rPrimary { return lPrimary < rPrimary }

    let ltKicker = lessThanWild(lhs.kickers, rhs.kickers)
    if ltKicker.hasResult { return ltKicker.result }
    return lhs.kickers! < rhs.kickers!
}

extension HandEvaluationResult : CustomStringConvertible {
    public var description: String {
        guard let rank = rank else { return "wild" }

        var output = rank.description

        if let primary = primary {
            let cardString = primary.allCards.prettyDescription()
            output += " (\(cardString))"
        }

        if let kickers = kickers {
            let kickerString = kickers.allCards.prettyDescription(ascending:false)
            output += " \(kickerString)"
        }
        
        return output
    }
}
