//
//  Created on 7/28/16.
//

import XCTest
@testable import PokerKit

class HighHandEvaluatorTests: XCTestCase {
    let evaluator = HighHandEvaluator(configuration: DefaultConfiguration())
    
    func testThings() {
        let hand = PlayingCard.hand("ac 2c 3c 4c 5c")

        let hand2 = PlayingCard.hand("jh jc jd qs qC")

        var expected: [HandEvaluationResult]

        expected = [HandEvaluationResult(rank: .straightFlush, primary: nil, kickers: hand),
                    HandEvaluationResult(rank: .fullHouse, primary: nil, kickers: hand2)]
        var results = evaluator.evaluateHands([hand, hand2])
        XCTAssertEqual(results, expected)
        
        let hand3 = PlayingCard.hand("ac ts td 9c kh")
        expected = [ HandEvaluationResult(rank: .pair, primary: nil, kickers: hand3)]
        results = evaluator.evaluateHands([hand3])
        XCTAssertEqual(results, expected)
    }

    
    func testWheel() {
        let wheel = PlayingCard.hand("ac 2c 3s 4c 5c")
        let results = evaluator.evaluateHand(wheel)
        let expected = HandEvaluationResult(rank: .straight, primary: wheel, kickers: nil)
        XCTAssertEqual(results.first, expected)
    }
}
