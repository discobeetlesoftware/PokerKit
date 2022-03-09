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

extension Rank : EmojiDescription {
    var emojiDescription: String {
        let list = "--2⃣️3⃣️4⃣️5⃣️6⃣️7⃣️8⃣️9⃣️🔟ⒿⓆⓀⒶ"
        let char = list[list.characters.index(list.startIndex, offsetBy: rawValue)]
        return String(char)
    }
}

extension Suit : EmojiDescription {
    var emojiDescription: String {
        switch self {
        case .spades: return "♠️"
        case .hearts: return "♥️"
        case .diamonds: return "♦️"
        case .clubs: return "♣️"
        }
    }
}

extension String {
    func substring(_ n:Int) -> String {
        let char = self[self.characters.index(self.startIndex, offsetBy: n)]
        return String(char)
    }
}

extension PlayingCard : UnicodeDescription {
    static let unicodes:[String] = {
        return [
            "🂡🂢🂣🂤🂥🂦🂧🂨🂩🂪🂫🂭🂮",
            "🂱🂲🂳🂴🂵🂶🂷🂸🂹🂺🂻🂽🂾",
            "🃁🃂🃃🃄🃅🃆🃇🃈🃉🃊🃋🃍🃎",
            "🃑🃒🃓🃔🃕🃖🃗🃘🃙🃚🃛🃝🃞"
        ]
    }()
    var unicodeDescription: String {
        return PlayingCard.unicodes[suit.rawValue].substring(rank.rawValue)
    }
}
