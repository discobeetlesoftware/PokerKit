//
//  Created on 4/5/17.
//

struct HighHandAnalysis {
    let model: HandEvaluationModel
    
    typealias RankAnalysis = [Int:[Hand]]
    lazy var rankAnalysis: RankAnalysis = { return analyzeRanks() }()
    
    typealias StraightAnalysis = [Hand]
    lazy var straightAnalysis: StraightAnalysis = { return analyzeSequences() }()
    
    typealias SuitAnalysis = [Hand]
    lazy var suitAnalysis: SuitAnalysis = { return analyzeSuits() }()
    
    lazy var hasQuints: Bool = { return rankAnalysis[5] != nil }()
    lazy var hasQuads: Bool = { return rankAnalysis[4] != nil }()
    lazy var hasTrips: Bool = { return rankAnalysis[3] != nil }()
    lazy var hasPairs: Bool = { return rankAnalysis[2] != nil }()
    lazy var hasFlush: Bool = { return suitAnalysis.count > 0 }()
    lazy var hasStraight: Bool = { return straightAnalysis.count > 0 }()
    
    init (_ model: HandEvaluationModel) {
        self.model = model
    }
    
    func analyzeRanks() -> RankAnalysis {
        let matchingRanks = model.allCardsByRank
        
        let ranks = matchingRanks.keys.sorted { $0 > $1 }
        var results = RankAnalysis()
        for rank in ranks {
            let hand = matchingRanks[rank]!
            if let list = results[hand.count] {
                results[hand.count] = list + [hand]
            } else {
                results[hand.count] = [hand]
            }
        }
        return results
    }
    
    func analyzeSequences() -> StraightAnalysis {
        let matchingSequences = model.allCardsBySequence
        let straights: StraightAnalysis = matchingSequences.values.compactMap {
            if $0.count >= model.configuration.cardCount {
                return $0
            } else {
                return nil
            }
            
        }
        return straights
    }
    
    func analyzeSuits() -> SuitAnalysis {
        let matchingSuits = model.allCardsBySuit
        let flushes: SuitAnalysis = matchingSuits.values.compactMap {
            return $0.count >= model.configuration.cardCount ? $0 : nil
        }
        return flushes
    }
    
    mutating func fiveOfAKindResult() -> HandEvaluationResult? {
        if hasQuints {
            return HandEvaluationResult(rank: HandRank.fiveOfKind, hand: model, rankHand: rankAnalysis[5]!.first)
        } else {
            return nil
        }
    }

    mutating func straightFlushResult() -> HandEvaluationResult? {
        guard hasStraight && hasFlush else { return nil }

        let straightFlush = straightAnalysis.first(where: { straight in
            return suitAnalysis.contains(where: { flush in
                print("\(straight)==\(flush)")
                return straight.reduce(true) {
                    return $0 && flush.contains($1)
                }
            })
        })
        guard let hand = straightFlush else { return nil }
        let rankHand = Array(hand.suffix(model.configuration.cardCount))
        return HandEvaluationResult(rank: HandRank.straightFlush, hand: model, rankHand: rankHand)
    }
    
    mutating func fourOfAKindResult() -> HandEvaluationResult? {
        if hasQuads {
            return HandEvaluationResult(rank: HandRank.fourOfKind, hand: model, rankHand: rankAnalysis[4]!.first)
        } else {
            return nil
        }
    }
    
    mutating func fullHouseResult() -> HandEvaluationResult? {
        if hasTrips && hasPairs {
            let rankHand = rankAnalysis[3]!.first! + rankAnalysis[2]!.first!
            return HandEvaluationResult(rank: HandRank.fullHouse, hand: model, rankHand: rankHand)
        } else {
            return nil
        }
    }
    
    mutating func flushResult() -> HandEvaluationResult? {
        if hasFlush {
            let rankHand: Hand? = {
                guard let hand = suitAnalysis.last else { return nil }
                return Array(hand.suffix(model.configuration.cardCount))
            }()
            return HandEvaluationResult(rank: HandRank.flush, hand: model, rankHand: rankHand)
        } else {
            return nil
        }
    }
    
    mutating func straightResult() -> HandEvaluationResult? {
        if hasStraight {
            let rankHand: Hand? = {
                guard let hand = straightAnalysis.last else { return nil }
                return Array(hand.suffix(model.configuration.cardCount))
            }()
            return HandEvaluationResult(rank: HandRank.straight, hand: model, rankHand: rankHand)
        } else {
            return nil
        }
    }
    
    mutating func threeOfAKindResult() -> HandEvaluationResult? {
        if hasTrips {
            return HandEvaluationResult(rank: HandRank.threeOfKind, hand: model, rankHand: rankAnalysis[3]!.first)
        } else {
            return nil
        }
    }
    
    mutating func twoPairResult() -> HandEvaluationResult? {
        if hasPairs && rankAnalysis[2]!.count > 1 {
            let rankHand = rankAnalysis[2]!.last! + rankAnalysis[2]!.first!
            return HandEvaluationResult(rank: HandRank.twoPair, hand: model, rankHand: rankHand)
        } else {
            return nil
        }
    }
    
    mutating func pairResult() -> HandEvaluationResult? {
        if hasPairs {
            return HandEvaluationResult(rank: HandRank.pair, hand: model, rankHand: rankAnalysis[2]!.first!)
        } else {
            return nil
        }
    }
    
    mutating func highCardResult() -> HandEvaluationResult {
        return HandEvaluationResult(rank: HandRank.highCard, hand: model, rankHand: nil)
    }
}
