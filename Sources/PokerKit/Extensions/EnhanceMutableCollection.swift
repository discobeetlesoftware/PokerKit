//
//  Created on 7/28/16.
//

import Foundation

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
