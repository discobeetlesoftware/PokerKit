//
//  Created on 8/14/16.
//

import XCTest
@testable import PokerKit

class PrettyDescriptionTests: XCTestCase {

    func testRankEmoji() {
        XCTAssertEqual(Rank.ace.emojiDescription, "Ⓐ")
        XCTAssertEqual(Rank.king.emojiDescription, "Ⓚ")
        XCTAssertEqual(Rank.queen.emojiDescription, "Ⓠ")
        XCTAssertEqual(Rank.jack.emojiDescription, "Ⓙ")
        XCTAssertEqual(Rank.ten.emojiDescription, "🔟")
        XCTAssertEqual(Rank.nine.emojiDescription, "9⃣️")
        XCTAssertEqual(Rank.eight.emojiDescription, "8⃣️")
        XCTAssertEqual(Rank.seven.emojiDescription, "7⃣️")
        XCTAssertEqual(Rank.six.emojiDescription, "6⃣️")
        XCTAssertEqual(Rank.five.emojiDescription, "5⃣️")
        XCTAssertEqual(Rank.four.emojiDescription, "4⃣️")
        XCTAssertEqual(Rank.three.emojiDescription, "3⃣️")
        XCTAssertEqual(Rank.two.emojiDescription, "2⃣️")
        XCTAssertEqual(Rank.aceLow.emojiDescription, "Ⓐ")
    }
    
    func testSuitEmoji() {
        XCTAssertEqual(Suit.spades.emojiDescription, "♠️")
        XCTAssertEqual(Suit.hearts.emojiDescription, "♥️")
        XCTAssertEqual(Suit.diamonds.emojiDescription, "♦️")
        XCTAssertEqual(Suit.clubs.emojiDescription, "♣️")
    }
    
    func testPlayingCardUnicode() {
        XCTAssertEqual(PlayingCard(rank: Rank.king, suit: Suit.spades).unicodeDescription, "🂮")
        XCTAssertEqual(PlayingCard(rank: Rank.aceLow, suit: Suit.hearts).unicodeDescription, "🂱")
        XCTAssertEqual(PlayingCard(rank: Rank.eight, suit: Suit.diamonds).unicodeDescription, "🃈")
        XCTAssertEqual(PlayingCard(rank: Rank.three, suit: Suit.clubs).unicodeDescription, "🃓")
    }
}
