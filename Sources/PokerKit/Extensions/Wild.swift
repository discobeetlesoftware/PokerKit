//
//  Created on 8/10/16.
//

func equalWild<T>(_ left: Optional<T>, _ right: Optional<T>) -> Bool {
    switch (left, right) {
    case (.none, _), (_, .none):
        return true
    default:
        return false
    }
}

func lessThanWild<T>(_ left: Optional<T>, _ right: Optional<T>) -> Bool? {
    switch (left, right) {
    case (.none, .none):
        return false
    case (_, .none):
        return true
    case (.none, _):
        return false
    default:
        return nil
    }
}
