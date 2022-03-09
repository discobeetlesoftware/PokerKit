//
//  Created on 7/28/16.
//

import XCTest
@testable import PokerKit

class HandRankTests: XCTestCase {
    func testStaticAll() {
        let list = HandRank.all()
        XCTAssertEqual(list.count, 12)
        XCTAssertEqual(list.sorted(), list)
    }

    func testEquatble() {
        XCTAssertEqual(HandRank.invalid, HandRank.invalid)
        XCTAssertEqual(HandRank.all(), HandRank.all())
        XCTAssertNotEqual(HandRank.straight, HandRank.straightFlush)
    }

    func testComparable() {
        let expected:[HandRank] = [.highCard, .pair, .pair]
        let ranks:[HandRank] = [.pair, .highCard, .pair]
        XCTAssertEqual(ranks.sorted(), expected)

        let all = HandRank.all()
        let reverse = Array(all.reversed())
        XCTAssertNotEqual(reverse, all)
        XCTAssertEqual(reverse.sorted(), all)
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
