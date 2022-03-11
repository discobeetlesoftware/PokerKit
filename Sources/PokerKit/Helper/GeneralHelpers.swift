//
//  Created on 8/14/16.
//

import Foundation

/**
 Takes a pointer to some T?, as well as a callback producing T which
 provides nil-able lazy var loading in old-school Objective-C style

 - parameter ptr:      Pointer to some T?
 - parameter callback: Function producing a T

 - returns: T from ptr, perhaps recently allocated
 */
public struct Global {
    static func lazyInit<T>(_ ptr: inout T?, _ callback: (() -> T)) -> T {
        if ptr == nil {
            ptr = callback()
        }
        return ptr!
    }
}
