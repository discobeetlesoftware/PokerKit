//
//  Created on 8/10/16.
//

import XCTest
@testable import PokerKit

class EnhanceOptionalTests: XCTestCase {

    func testEqualWild() {
        let value:String? = "value"
        let noval:String? = nil
        XCTAssertTrue(equalWild(noval, value))
        XCTAssertTrue(equalWild(value, noval))
        XCTAssertTrue(equalWild(noval, noval))
        XCTAssertFalse(equalWild(value, value))
    }

    func testLessThanWild() {
        let value:String? = "value"
        let noval:String? = nil
        var result = lessThanWild(noval, value)
        XCTAssertTrue(result.hasResult)
        XCTAssertFalse(result.result)

        result = lessThanWild(value, noval)
        XCTAssertTrue(result.hasResult)
        XCTAssertTrue(result.result)

        result = lessThanWild(noval, noval)
        XCTAssertTrue(result.hasResult)
        XCTAssertTrue(result.result)

        result = lessThanWild(value, value)
        XCTAssertFalse(result.hasResult)
        XCTAssertFalse(result.result)
    }

}
