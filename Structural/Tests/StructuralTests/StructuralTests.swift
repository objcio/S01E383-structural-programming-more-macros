import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import Structural
import StructuralMacros

let testMacros: [String: Macro.Type] = [
    "Structural": StructuralMacro.self,
]

final class StructuralTests: XCTestCase {
    func testMacro() throws {
        assertMacroExpansion(
            """
            @Structural
            struct Test {
                var foo: String
                var bar: Int
            }
            """,
            expandedSource: """
            struct Test {
                var foo: String
                var bar: Int

                typealias Structure = Struct<List<Property<String>, List<Property<Int>, Empty>>>

                static var structure: Structure {
                    Struct(name: "Test", properties: List(head: Property(name: "foo"), tail: List(head: Property(name: "bar"), tail: Empty())))
                }

                var to: Structure.Value {
                    (foo, (bar, ()))
                }

                static func from(_ s: Structure.Value) -> Self {
                    .init(foo: s.0, bar: s.1.0)
                }
            }

            extension Test: Structural {
            }
            """,
            macros: testMacros
        )
    }

}
