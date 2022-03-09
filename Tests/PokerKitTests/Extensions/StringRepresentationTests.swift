//
//  Created on 7/28/16.
//

import XCTest
@testable import PokerKit

class StringRepresentationTests: XCTestCase {
    func testListFrom() {
        var list = Suit.listFrom("s c s dinosaur d s h")
        XCTAssertEqual(list.count, 6)
        XCTAssertEqual(list.first!, Suit.spades)
        XCTAssertEqual(list.last!, Suit.hearts)

        list = Suit.listFrom("P Q H")
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.first!, Suit.hearts)
        XCTAssertEqual(list.last!, Suit.hearts)

        list = Suit.listFrom("spade heart santa")
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(list.first!, Suit.spades)
        XCTAssertEqual(list.last!, Suit.hearts)
    }

    func testRankFrom() {
        XCTAssertEqual(Rank.from("2"), Rank.two)
        XCTAssertEqual(Rank.from("3"), Rank.three)
        XCTAssertEqual(Rank.from("4"), Rank.four)
        XCTAssertEqual(Rank.from("5"), Rank.five)
        XCTAssertEqual(Rank.from("6"), Rank.six)
        XCTAssertEqual(Rank.from("7"), Rank.seven)
        XCTAssertEqual(Rank.from("8"), Rank.eight)
        XCTAssertEqual(Rank.from("9"), Rank.nine)
        XCTAssertEqual(Rank.from("t"), Rank.ten)
        XCTAssertEqual(Rank.from("j"), Rank.jack)
        XCTAssertEqual(Rank.from("q"), Rank.queen)
        XCTAssertEqual(Rank.from("k"), Rank.king)
        XCTAssertEqual(Rank.from("a"), Rank.ace)
        XCTAssertNil(Rank.from(""))
        XCTAssertNil(Rank.from("worf"))
        XCTAssertNil(Rank.from("-"))
        XCTAssertNil(Rank.from("A"))
    }

    func testSuitFrom() {
        XCTAssertEqual(Suit.from("s"), Suit.spades)
        XCTAssertEqual(Suit.from("h"), Suit.hearts)
        XCTAssertEqual(Suit.from("c"), Suit.clubs)
        XCTAssertEqual(Suit.from("d"), Suit.diamonds)

        XCTAssertEqual(Suit.from("sp"), Suit.spades)
        XCTAssertEqual(Suit.from("hearts"), Suit.hearts)
        XCTAssertEqual(Suit.from("club"), Suit.clubs)
        XCTAssertEqual(Suit.from("di"), Suit.diamonds)

        XCTAssertNil(Suit.from("S"))
        XCTAssertNil(Suit.from("-"))
        XCTAssertNil(Suit.from(""))
        XCTAssertNil(Suit.from("1"))
    }

    func testPlayingCardFrom() {
        func make(_ rank: String, _ suit: String) -> PlayingCard? {
            return PlayingCard(rank: Rank.from(rank)!, suit: Suit.from(suit)!)
        }
        XCTAssertEqual(PlayingCard.from("ah"), make("a","h"))
        XCTAssertEqual(PlayingCard.from("jd"), make("j","d"))
        XCTAssertEqual(PlayingCard.from("kc"), make("k","c"))
        XCTAssertEqual(PlayingCard.from("2h"), make("2","h"))
        XCTAssertEqual(PlayingCard.from("tc"), make("t","c"))

        XCTAssertNil(PlayingCard.from("ty"))
        XCTAssertNil(PlayingCard.from("yh"))
        XCTAssertNil(PlayingCard.from("yy"))
        XCTAssertNil(PlayingCard.from(""))
        XCTAssertNil(PlayingCard.from("--"))
        XCTAssertNil(PlayingCard.from(" "))
    }
}
