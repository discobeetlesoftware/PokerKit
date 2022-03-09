//
//  Created on 7/28/16.
//

public protocol HandEvaluator {
    // Returns every hand result matching the provided hand
    func evaluateHand(_ hand: Hand) -> [HandEvaluationResult]

    // Return a HandEvaluatorResult for each provided hand
    func evaluateHands(_ hands: [Hand]) -> [HandEvaluationResult]
}
