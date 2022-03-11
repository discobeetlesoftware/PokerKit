//
//  Created on 4/4/17.
//

import XCTest
@testable import PokerKit

class EnhanceMutableCollectionTests: XCTestCase {
    func testShuffle() {
        var list = [0, 1, 2, 3, 4, 5]
        list.shuffle()
        XCTAssertNotEqual(list, [0, 1, 2, 3, 4, 5])
    }
    
    func testWrap() {
        let list = [0, 1, 2]
        XCTAssertEqual(list.wrap(0), 0)
        XCTAssertEqual(list.wrap(1), 1)
        XCTAssertEqual(list.wrap(2), 2)
        XCTAssertEqual(list.wrap(3), 0)
        XCTAssertEqual(list.wrap(4), 1)
        XCTAssertEqual(list.wrap(5), 2)
        XCTAssertEqual(list.wrap(6), 0)
    }
}
