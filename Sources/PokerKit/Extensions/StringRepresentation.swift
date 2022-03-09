//
//  Created on 7/28/16.
//

import Foundation

public protocol StringRepresentation : CustomStringConvertible {
    static func from(_ input: String) -> Self?
    static func listFrom(_ input: String) -> [Self]
}

extension StringRepresentation {
    static func representations(_ input: String) -> [String] {
        return input.lowercased().components(separatedBy: " ")
    }

    public static func listFrom(_ input: String) -> [Self] {
        return representations(input).flatMap { Self.from($0) }
    }
}

extension Rank : StringRepresentation {
    fileprivate static let All = "--23456789tjqka"
    public static func from(_ input: String) -> Rank? {
        guard input.characters.count == 1 else { return nil }
        if let range = Rank.All.range(of: input) {
            let rawValue = Rank.All.characters.distance(from: Rank.All.startIndex, to: range.lowerBound)
            return Rank(rawValue: rawValue)
        } else {
            return nil
        }
    }
}

extension Suit : StringRepresentation {
    fileprivate static let All = ["spades", "hearts", "diamonds", "clubs"]
    public static func from(_ input: String) -> Suit? {
        let index = Suit.All.index { $0.hasPrefix(input) }
        return index ~> { Suit(rawValue: $0) }
    }
}

extension PlayingCard : StringRepresentation {
    public static func from(_ input: String) -> PlayingCard? {
        guard input.characters.count > 1 else { return nil }
        let rankToken = input.substring(to: input.characters.index(input.startIndex, offsetBy: 1))
        let suitToken = input.substring(from: input.characters.index(input.startIndex, offsetBy: 1))
        if let rank = Rank.from(rankToken),
            let suit = Suit.from(suitToken) {
            return PlayingCard(rank: rank, suit: suit)
        } else {
            return nil
        }
    }
}

extension Hand : StringRepresentation {
    public static func from(_ input: String) -> Hand? {
        let cards = PlayingCard.listFrom(input)
        return Hand(cards)
    }
}
