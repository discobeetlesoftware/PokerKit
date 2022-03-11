//
//  Created on 8/14/16.
//

import Foundation

protocol UnicodeDescription {
    var unicodeDescription: String { get }
}

protocol EmojiDescription {
    var emojiDescription: String { get }
}

extension Rank: EmojiDescription {
    var emojiDescription: String {
        switch self {
        case .ace: return "Ⓐ"
        case .king: return "Ⓚ"
        case .queen: return "Ⓠ"
        case .jack: return "Ⓙ"
        case .ten: return "🔟"
        case .nine: return "9⃣️"
        case .eight: return "8⃣️"
        case .seven: return "7⃣️"
        case .six: return "6⃣️"
        case .five: return "5⃣️"
        case .four: return "4⃣️"
        case .three: return "3⃣️"
        case .two: return "2⃣️"
        case .aceLow: return "Ⓐ"
        case .invalid: return "🚫"
        }
    }
}

extension Suit: EmojiDescription {
    var emojiDescription: String {
        switch self {
        case .spades: return "♠️"
        case .hearts: return "♥️"
        case .diamonds: return "♦️"
        case .clubs: return "♣️"
        case .invalid: return "🚫"
        }
    }
}

extension PlayingCard: UnicodeDescription {
    fileprivate func unicodeCards() -> String {
        switch suit {
        case .spades: return "🂡🂢🂣🂤🂥🂦🂧🂨🂩🂪🂫🂭🂮🂡"
        case .hearts: return "🂱🂲🂳🂴🂵🂶🂷🂸🂹🂺🂻🂽🂾🂱"
        case .diamonds: return "🃁🃂🃃🃄🃅🃆🃇🃈🃉🃊🃋🃍🃎🃁"
        case .clubs: return "🃑🃒🃓🃔🃕🃖🃗🃘🃙🃚🃛🃝🃞🃑"
        case .invalid: return ""
        }
    }
    
    var unicodeDescription: String {
        let cards = unicodeCards()
        let index = cards.index(cards.startIndex, offsetBy: rank.rawValue - 1)
        let close = cards.index(after: index)
        let range = index..<close
        return String(cards[range])
    }
}
