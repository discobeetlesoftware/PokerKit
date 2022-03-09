//
//  Created on 7/28/16.
//

import Foundation

public typealias Collection = Swift.Collection

public protocol MutableCollection: Swift.MutableCollection {
    associatedtype IndexDistance
}

extension Array: MutableCollection {
    public typealias IndexDistance = Int
}

public extension MutableCollection where Index == Int, IndexDistance == Int {
    mutating func shuffle2() {
        guard count > 1 else { return }

        for i in 0..<count - 1 {
            let j = random(count - i) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

public extension Collection where Index == Int, IndexDistance == Int {
    func wrap(_ n: Int) -> Int {
        if self.count == 0 {
            return 0
        }
        let delta = n % self.count
        if delta < 0 {
            return self.count - delta + 1
        } else {
            return delta
        }
    }
}
