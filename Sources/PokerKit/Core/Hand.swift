//
//  Created on 7/28/16.
//

public typealias Hand = [PlayingCard]

extension Sequence where Iterator.Element == PlayingCard {
    func prettyDescription() -> String {
        return self.map { String(describing: $0) }.joined(separator: " ")
    }
    
    func groupBy<U: Hashable>(_ callback: (PlayingCard) -> U) -> [U: Hand] {
        var grouped = [U: Hand]()
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
