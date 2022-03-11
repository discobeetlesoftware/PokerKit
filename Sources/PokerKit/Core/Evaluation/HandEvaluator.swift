//
//  Created on 7/28/16.
//

public protocol HandEvaluator {
    init(configuration: HandEvaluatorConfiguration)
    
    func evaluate(_ hand: Hand) -> HandEvaluationResult
    
    // Returns every hand result matching the provided hand
    func evaluateHand(_ hand: Hand) -> [HandEvaluationResult]
}

extension HandEvaluator {
    public func evaluateHand(_ hand: Hand) -> [HandEvaluationResult] {
        return [evaluate(hand)]
    }
    
    func evaluateHands(_ hands: [Hand]) -> [HandEvaluationResult] {
        return hands.map { evaluate($0) }
    }
}
