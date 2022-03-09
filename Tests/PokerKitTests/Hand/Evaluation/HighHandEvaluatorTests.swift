//
//  Created on 7/28/16.
//

import XCTest
@testable import PokerKit

class HighHandEvaluatorTests: XCTestCase {
    func testThings() {

        let hand = Hand.from("ac 2c 3c 4c 5c")!

        let hand2 = Hand.from("jh jc jd qs qC")!

        let evaluator = HighHandEvaluator()
        var expected: [HandEvaluationResult]

        expected = [HandEvaluationResult(rank: .straightFlush, primary: nil, kickers: hand),
                    HandEvaluationResult(rank: .fullHouse, primary: nil, kickers: hand2)]
        var results = evaluator.evaluateHands([hand, hand2])
        XCTAssertEqual(results, expected)
        
        let hand3 = Hand.from("ac ts td 9c kh")!
        expected = [ HandEvaluationResult(rank: .pair, primary: nil, kickers: hand3)]
        results = evaluator.evaluateHands([hand3])
        XCTAssertEqual(results, expected)
    }

}
