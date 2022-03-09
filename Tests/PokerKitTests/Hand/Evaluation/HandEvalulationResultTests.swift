//
//  Created on 8/10/16.
//

import XCTest
@testable import PokerKit

class HandEvaluationResultTests: XCTestCase {
    func testInit() {
        let result1 = HandEvaluationResult(rank: nil, primary: nil, kickers: nil)
        XCTAssertNotNil(result1)
        XCTAssertNil(result1.rank)
        XCTAssertNil(result1.primary)
        XCTAssertNil(result1.kickers)

        let primary:Hand? = Hand.from("ah ac")
        let kickers:Hand? = Hand.from("2c 3c 4c")
        let result2 = HandEvaluationResult(rank: HandRank.pair, primary: primary, kickers: kickers)
        XCTAssertNotNil(result2)
        XCTAssertEqual(result2.rank, .pair)
        XCTAssertEqual(result2.primary!, primary)
        XCTAssertEqual(result2.kickers!, kickers)
    }

    func testEquatable_rank() {
        let rankWild = HandEvaluationResult()
        XCTAssertEqual(rankWild, rankWild)
        XCTAssertEqual(rankWild, HandEvaluationResult.invalid)
        XCTAssertEqual(HandEvaluationResult.invalid, rankWild)
        XCTAssertEqual(HandEvaluationResult.straightFlush, rankWild)
        XCTAssertEqual(HandEvaluationResult.threeOfKind, rankWild)
        XCTAssertEqual(HandEvaluationResult.pair, HandEvaluationResult.pair)
        XCTAssertEqual(HandEvaluationResult.fiveOfKind, HandEvaluationResult.fiveOfKind)
        XCTAssertEqual(HandEvaluationResult.fourOfKind, HandEvaluationResult.fourOfKind)
        XCTAssertEqual(HandEvaluationResult.straight, HandEvaluationResult.straight)
    }

    func testEquatable_primary() {
        let pairDeuces1 = HandEvaluationResult(rank: .pair, primary: Hand.from("2c 2s"), kickers: nil)
        let pairDeuces2 = HandEvaluationResult(rank: .pair, primary: Hand.from("2c 2s"), kickers: nil)
        XCTAssertEqual(pairDeuces1, pairDeuces2)
        XCTAssertEqual(pairDeuces2, pairDeuces1)
        XCTAssertEqual(pairDeuces2, HandEvaluationResult())

        let trips1 = HandEvaluationResult(rank: .threeOfKind, primary: Hand.from("3c 3h 3s"), kickers: nil)
        let trips2 = HandEvaluationResult(rank: .threeOfKind, primary: Hand.from("3c 3h 3d"), kickers: nil)
        XCTAssertNotEqual(trips1, trips2)
    }

    func testEquatable_kickers() {
        let pair1 = HandEvaluationResult(rank: .pair, primary: Hand.from("2c 2s"), kickers: Hand.from("3c 4h 5s"))
        let pair2 = HandEvaluationResult(rank: .pair, primary: Hand.from("2c 2s"), kickers: nil)
        XCTAssertEqual(pair1, pair2)
        XCTAssertEqual(pair2, pair1)
        XCTAssertEqual(pair1, HandEvaluationResult())

        let quads1 = HandEvaluationResult(rank: .fourOfKind, primary: Hand.from("4c 4s 4h 4d"), kickers: Hand.from("ah"))
        let quads2 = HandEvaluationResult(rank: .fourOfKind, primary: Hand.from("4c 4s 4h 4d"), kickers: Hand.from("2h"))
        XCTAssertNotEqual(quads1, quads2)
        XCTAssertNotEqual(quads2, quads1)
        XCTAssertEqual(quads1, HandEvaluationResult())
    }

}
