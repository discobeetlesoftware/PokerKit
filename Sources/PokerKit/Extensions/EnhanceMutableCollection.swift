//
//  Created on 7/28/16.
//

import Foundation

public typealias Collection = Swift.Collection

public extension MutableCollection where Index == Int {
    mutating func shuffle2() {
        guard count > 1 else { return }

        for i in 0..<count - 1 {
            let j = random(count - i) + i
            guard i != j else { continue }
            swapAt(i, j)
        }
    }
}

public extension Collection where Index == Int {
    func wrap(_ n: Int) -> Int {
        if count == 0 {
            return 0
        }
        let delta = n % count
        if delta < 0 {
            return count - delta + 1
        } else {
            return delta
        }
    }
}
