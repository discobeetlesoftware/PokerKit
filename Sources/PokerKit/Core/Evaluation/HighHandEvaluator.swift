//
//  Created on 7/28/16.
//

//import Dollar

open class HighHandEvaluator : HandEvaluator {

    typealias RankAnalysis = (quads: [Hand], trips: [Hand], pairs: [Hand])

    func analyzeRanks(_ hand: Hand) -> RankAnalysis {
        let matchingRanks = hand.allCardsByRank

        let ranks = matchingRanks.keys.sorted { $0 > $1 }
        var results = RankAnalysis([Hand](), [Hand](), [Hand]())
        for rank in ranks {
            let hand = matchingRanks[rank]!
            switch hand.count {
            case 2:
                results.pairs.append(hand)
            case 3:
                results.trips.append(hand)
            case 4:
                results.quads.append(hand)
            default:
                break
            }
        }
        return results
    }

    typealias StraightAnalysis = [Hand]
    func analyzeSequences(_ hand: Hand) -> StraightAnalysis {
        let matchingSequences = hand.allCardsBySequence
        let straights:StraightAnalysis = matchingSequences.values.compactMap {
            if $0.count == hand.schema.cardCount {
                return $0
            } else {
                return nil
            }

        }
        return straights
    }

    typealias SuitAnalysis = [Hand]
    func analyzeSuits(_ hand: Hand) -> SuitAnalysis {
        let matchingSuits = hand.allCardsBySuit
        let flushes:SuitAnalysis = matchingSuits.values.compactMap {
            return $0.count == hand.schema.cardCount ? $0 : nil
        }
        return flushes
    }

    open func evaluateHand(_ hand: Hand) -> [HandEvaluationResult] {
        let (quads, trips, pairs) = analyzeRanks(hand)
        let (hasQuads, hasTrips, hasPairs) = (quads.count > 0, trips.count > 0, pairs.count > 0)

        let straights = analyzeSequences(hand)
        let hasStraight = straights.last != nil

        let flushes = analyzeSuits(hand)
        let hasFlush = flushes.last != nil

        var results: [HandEvaluationResult] = []
        func appendResult(_ rank: HandRank, _ resultHand: Hand?) {
            let primary = resultHand ?? hand
            let kickerCount = max(0, hand.schema.cardCount - primary.count)
            var cards = hand.allCards
            cards.removeAll(where: { primary.allCards.contains($0) })
            let kickers: Hand? = Hand(Array(cards.prefix(kickerCount)))
            let result = HandEvaluationResult(rank: rank, primary: primary, kickers: kickers)
            results.append(result)
        }

        if hasStraight && hasFlush {
            appendResult(HandRank.straightFlush, flushes.first)//not correct sometimes
        }

        if hasQuads {
            appendResult(HandRank.fourOfKind, quads.first)
        }

        if hasTrips && hasPairs {
            appendResult(HandRank.fullHouse, trips.first! + pairs.first!)
        }

        if hasFlush {
            appendResult(HandRank.flush, flushes.first)
        }

        if hasStraight {
            appendResult(HandRank.straight, straights.first)
        }

        if hasTrips {
            appendResult(HandRank.threeOfKind, trips.first)
        }

        if hasPairs && pairs.count > 1 {
            appendResult(HandRank.twoPair, pairs.first! + pairs.last!)
        }

        if hasPairs {
            appendResult(HandRank.pair, pairs.first)
        }

        return results
    }

    open func evaluateHands(_ hands: [Hand]) -> [HandEvaluationResult] {
        return hands.map({ hand in
            let matchingHands = evaluateHand(hand)
            if let bestHand = matchingHands.first {
                return bestHand
            } else {
                return HandEvaluationResult(rank: HandRank.highCard, primary: hand, kickers: nil)
            }
        })
    }
}
