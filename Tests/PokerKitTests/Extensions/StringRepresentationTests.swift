//
//  Created on 7/28/16.
//

import XCTest
@testable import PokerKit

class StringRepresentationTests: XCTestCase {
    
    func testSuit() {
        let suit0: Suit = "i"
        XCTAssertEqual(suit0, Suit.invalid)
        
        let suit1: Suit = ""
        XCTAssertEqual(suit1, Suit.invalid)
        
        let suit2: Suit = "s"
        XCTAssertEqual(suit2, Suit.spades)
        
        let suit3: Suit = "h"
        XCTAssertEqual(suit3, Suit.hearts)
        
        let suit4: Suit = "d"
        XCTAssertEqual(suit4, Suit.diamonds)
        
        let suit5: Suit = "c"
        XCTAssertEqual(suit5, Suit.clubs)
    }
    
    func testRank() {
        let rank0: Rank = ""
        XCTAssertEqual(rank0, Rank.invalid)
        
        let rank1: Rank = "1"
        XCTAssertEqual(rank1, Rank.aceLow)
        
        let rank2: Rank = "2"
        XCTAssertEqual(rank2, Rank.two)
        
        let rank3: Rank = "3"
        XCTAssertEqual(rank3, Rank.three)
        
        let rank4: Rank = "4"
        XCTAssertEqual(rank4, Rank.four)
        
        let rank5: Rank = "5"
        XCTAssertEqual(rank5, Rank.five)
        
        let rank6: Rank = "6"
        XCTAssertEqual(rank6, Rank.six)
        
        let rank7: Rank = "7"
        XCTAssertEqual(rank7, Rank.seven)
        
        let rank8: Rank = "8"
        XCTAssertEqual(rank8, Rank.eight)
        
        let rank9: Rank = "9"
        XCTAssertEqual(rank9, Rank.nine)
        
        let rank10: Rank = "T"
        XCTAssertEqual(rank10, Rank.ten)
        
        let rank11: Rank = "J"
        XCTAssertEqual(rank11, Rank.jack)
        
        let rank12: Rank = "Q"
        XCTAssertEqual(rank12, Rank.queen)
        
        let rank13: Rank = "K"
        XCTAssertEqual(rank13, Rank.king)
        
        let rank14: Rank = "A"
        XCTAssertEqual(rank14, Rank.ace)
    }
    
    func testPlayingCard() {
        let card0: PlayingCard = ""
        XCTAssertEqual(card0, PlayingCard(rank: Rank.invalid, suit: Suit.invalid))
        
        let card1: PlayingCard = "a"
        XCTAssertEqual(card1, PlayingCard(rank: Rank.invalid, suit: Suit.invalid))
        
        let card2: PlayingCard = "as"
        XCTAssertEqual(card2, PlayingCard(rank: Rank.ace, suit: Suit.spades))
        
        let card3: PlayingCard = "2d"
        XCTAssertEqual(card3, PlayingCard(rank: Rank.two, suit: Suit.diamonds))
        
        let card4: PlayingCard = "3c"
        XCTAssertEqual(card4, PlayingCard(rank: Rank.three, suit: Suit.clubs))
        
        let card5: PlayingCard = "4h"
        XCTAssertEqual(card5, PlayingCard(rank: Rank.four, suit: Suit.hearts))
        
        let card6: PlayingCard = "ah "
        XCTAssertEqual(card6, PlayingCard(rank: Rank.invalid, suit: Suit.invalid))
    }
}
