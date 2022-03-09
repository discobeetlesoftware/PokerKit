//
//  Created on 8/13/16.
//

import Foundation

extension Sequence where Iterator.Element == PlayingCard {
    func prettyDescription(ascending:Bool = true) -> String {
        let sorted = ascending ? self.sorted() : self.sorted { $1 < $0 }
        return sorted.map { String(describing: $0) }.joined(separator: " ")
    }

    func groupBy<U: Hashable>(_ callback: (PlayingCard) -> U) -> [U: [PlayingCard]] {
        var grouped = [U: [PlayingCard]]()
        for element in self {
            let key = callback(element)
            if var arr = grouped[key] {
                arr.append(element)
                grouped[key] = arr
            } else {
                grouped[key] = [element]
            }
        }
        return grouped
    }
}

// Assumes ordered params
public func <(lhs: [PlayingCard], rhs: [PlayingCard]) -> Bool {
    if lhs.count == 0 && rhs.count == 0 {
        return true
    } else if rhs.count == 0 {
        return true
    } else if lhs.count == 0 {
        return false
    }
    var lhs = lhs, rhs = rhs
    var lCard:PlayingCard, rCard:PlayingCard
    repeat {
        lCard = lhs.removeFirst()
        rCard = rhs.removeFirst()
    } while (lhs.count > 0 && rhs.count > 0) && lCard.rank == rCard.rank
    return lCard.rank < rCard.rank
}
