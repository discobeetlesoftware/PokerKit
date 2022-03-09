//
//  Created on 7/28/16.
//

import XCTest
@testable import PokerKit

class EnhancePlayingCardTests: XCTestCase {

    func testPrettyDescription() {
        let wheel = PlayingCard.listFrom("as 2h 3c 4d 5s")
        let deuceToSix = PlayingCard.listFrom("2c 3c 4c 5c 6s")

        XCTAssertEqual(wheel.prettyDescription(), "♡2 ♣︎3 ♢4 ♠︎5 ♠︎A")
        XCTAssertEqual(deuceToSix.prettyDescription(), "♣︎2 ♣︎3 ♣︎4 ♣︎5 ♠︎6")
        XCTAssertEqual(wheel.prettyDescription(ascending: false), "♠︎A ♠︎5 ♢4 ♣︎3 ♡2")
        XCTAssertEqual(deuceToSix.prettyDescription(ascending: false), "♠︎6 ♣︎5 ♣︎4 ♣︎3 ♣︎2")

        print(wheel.prettyDescription())
        print(deuceToSix.prettyDescription())
    }

    func testPlayingCardLessThan() {
        let empty: [PlayingCard] = PlayingCard.listFrom("")
        let ace: [PlayingCard] = PlayingCard.listFrom("as")
        let deuce: [PlayingCard] = PlayingCard.listFrom("2c")

        XCTAssertTrue(empty < empty)
        XCTAssertTrue(ace < empty)
        XCTAssertFalse(empty < ace)

        XCTAssertFalse(ace < ace)
        XCTAssertTrue(deuce < ace)
        XCTAssertFalse(ace < deuce)
    }

}
