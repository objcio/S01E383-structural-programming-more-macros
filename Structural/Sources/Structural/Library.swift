import Foundation

public protocol Structural {
    associatedtype Structure: Representation
    static var structure: Structure { get }
    var to: Structure.Value { get }
    static func from(_ s: Structure.Value) -> Self
}

public protocol Representation {
    associatedtype Value
}

public struct Struct<Properties> {
    public init(name: String, properties: Properties) {
        self.name = name
        self.properties = properties
    }

    public var name: String
    public var properties: Properties
}

extension Struct: Representation where Properties: Representation {
    public typealias Value = Properties.Value
}

public struct Enum<Cases> {
    public init(name: String, cases: Cases) {
        self.name = name
        self.cases = cases
    }

    public var name: String
    public var cases: Cases
}

extension Enum: Representation where Cases: Representation {
    public typealias Value = Cases.Value
}

public struct Property<Value> {
    public init(name: String) {
        self.name = name
    }

    public var name: String
}

extension Property: Representation {
}

public struct List<Head, Tail> {
    public init(head: Head, tail: Tail) {
        self.head = head
        self.tail = tail
    }

    public var head: Head
    public var tail: Tail
}

extension List: Representation where Head: Representation, Tail: Representation {
    public typealias Value = (Head.Value, Tail.Value)
}

public struct Choice<First, Second> {
    let first: First
    let second: Second
}

extension Choice: Representation where First: Representation, Second: Representation {
    public typealias Value = Either<First.Value, Second.Value>
}

public enum Either<First, Second> {
    case first(First)
    case second(Second)
}

public struct Empty {
    public init() { }
}

extension Empty: Representation {
    public typealias Value = ()
}

public enum Nothing {}

extension Nothing: Representation {
    public typealias Value = Nothing
}
