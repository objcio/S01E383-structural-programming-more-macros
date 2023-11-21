//

import Foundation
import Structural

@Structural
struct Simple {
    var foo: String
    var bar: Date
}


@Structural
struct Book {
    var title: String
    var published: Date
    var authors: String
    var updated: Bool
    var description: String = "My book description"
    var lastUpdate: Date = .distantPast
}


@Structural
struct BookUpdate {
    var description: String
    var date: Date
}
//
//@Structural
//enum Test {
//    case one
//    case two(String, label: Int)
//    case three
//}
//
//@Structural
//enum BookType {
//    case paperback
//    case hardcover(title: String, published: Date)
//}
