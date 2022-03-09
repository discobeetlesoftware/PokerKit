//
//  Created on 8/10/16.
//

func equalWild<T>(_ left:Optional<T>, _ right:Optional<T>) -> Bool {
    switch (left, right) {
    case (.none, _), (_, .none):
        return true
    default:
        return false
    }
}

func lessThanWild<T>(_ left:Optional<T>, _ right:Optional<T>) -> (result:Bool, hasResult:Bool) {
    var result = false, hasResult = false
    switch (left, right) {
    case (_, .none):
        result = true
        hasResult = true
    case (.none, _):
        hasResult = true
    default:
        break
    }
    return (result:result, hasResult:hasResult)
}
