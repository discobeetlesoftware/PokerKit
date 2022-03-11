//
//  Created on 7/28/16.
//

import XCTest
@testable import PokerKit

class HandRankTests: XCTestCase {
    func testValue() {
        let values = HandRank.all().map { $0.rawValue }
        let expected = Array(stride(from: 0, through: 12, by: 1))
        XCTAssertEqual(values, expected)
    }
    
    func testAll() {
        let allRanks = HandRank.all()
        XCTAssertEqual(allRanks.count, 13)
    }
    
    func testEquatable() {
        XCTAssertEqual(HandRank.low, HandRank.low)
        XCTAssertEqual(HandRank.twoPair, HandRank.twoPair)
        XCTAssertEqual(HandRank.straight, HandRank.straight)
        XCTAssertEqual(HandRank.straightFlush, HandRank.straightFlush)
        XCTAssertNotEqual(HandRank.low, HandRank.invalid)
    }
    
    func testComparable() {
        XCTAssertLessThan(HandRank.invalid, HandRank.low)
        XCTAssertLessThan(HandRank.low, HandRank.highCard)
        XCTAssertLessThan(HandRank.highCard, HandRank.pair)
        XCTAssertLessThan(HandRank.pair, HandRank.twoPair)
        XCTAssertLessThan(HandRank.twoPair, HandRank.threeOfKind)
        XCTAssertLessThan(HandRank.threeOfKind, HandRank.straight)
        XCTAssertLessThan(HandRank.straight, HandRank.flush)
        XCTAssertLessThan(HandRank.flush, HandRank.fullHouse)
        XCTAssertLessThan(HandRank.fullHouse, HandRank.fourOfKind)
        XCTAssertLessThan(HandRank.fourOfKind, HandRank.straightFlush)
        XCTAssertLessThan(HandRank.straightFlush, HandRank.fiveOfKind)
    }
    
    func testDescription() {
        XCTAssertEqual(HandRank.invalid.description, "invalid")
        XCTAssertEqual(HandRank.low.description, "low")
        XCTAssertEqual(HandRank.highCard.description, "high")
        XCTAssertEqual(HandRank.pair.description, "pair")
        XCTAssertEqual(HandRank.twoPair.description, "two pair")
        XCTAssertEqual(HandRank.threeOfKind.description, "trips")
        XCTAssertEqual(HandRank.straight.description, "straight")
        XCTAssertEqual(HandRank.flush.description, "flush")
        XCTAssertEqual(HandRank.fullHouse.description, "full house")
        XCTAssertEqual(HandRank.fourOfKind.description, "quads")
        XCTAssertEqual(HandRank.straightFlush.description, "straight flush")
        XCTAssertEqual(HandRank.fiveOfKind.description, "five of a kind")
    }
}
