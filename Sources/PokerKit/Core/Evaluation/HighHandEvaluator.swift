//
//  Created on 7/28/16.
//

public class HighHandEvaluator: HandEvaluator {
    let configuration: HandEvaluatorConfiguration
    
    public required init(configuration: HandEvaluatorConfiguration) {
        self.configuration = configuration
    }
    
    public func evaluate(_ cards: Hand) -> HandEvaluationResult {
        let model = HandEvaluationModel(withCards: cards)
        var analysis = HighHandAnalysis(model)
        if let result = analysis.fiveOfAKindResult() { return result }
        if let result = analysis.straightFlushResult() { return result }
        if let result = analysis.fourOfAKindResult() { return result }
        if let result = analysis.fullHouseResult() { return result }
        if let result = analysis.flushResult() { return result }
        if let result = analysis.straightResult() { return result }
        if let result = analysis.threeOfAKindResult() { return result }
        if let result = analysis.twoPairResult() { return result }
        if let result = analysis.pairResult() { return result }
        
        return analysis.highCardResult()
    }
    
    open func evaluateHand(_ hand: Hand) -> [HandEvaluationResult] {
        let model = HandEvaluationModel(withCards: hand)
        var analysis = HighHandAnalysis(model)
        var results: [HandEvaluationResult] = []
        if let result = analysis.fiveOfAKindResult() { results.append(result) }
        if let result = analysis.straightFlushResult() { results.append(result) }
        if let result = analysis.fourOfAKindResult() { results.append(result) }
        if let result = analysis.fullHouseResult() { results.append(result) }
        if let result = analysis.flushResult() { results.append(result) }
        if let result = analysis.straightResult() { results.append(result) }
        if let result = analysis.threeOfAKindResult() { results.append(result) }
        if let result = analysis.twoPairResult() { results.append(result) }
        if let result = analysis.pairResult() { results.append(result) }
        
        results.append(analysis.highCardResult())
        return results
    }
}
