//

import Foundation
import SwiftUI

public protocol ToView {
    associatedtype V: View
    @ViewBuilder var view: V { get }
}

public protocol RepresentationToView: Representation {
    associatedtype V: View
    @ViewBuilder func view(_ value: Value) -> V
}


extension Empty: RepresentationToView {
    public func view(_ value: ()) -> some View {
        EmptyView()
    }
}


extension Property: RepresentationToView where Value: ToView {
    public func view(_ value: Value) -> some View {
        LabeledContent(name) {
            value.view
        }
    }
}

extension List: RepresentationToView where Head: RepresentationToView, Tail: RepresentationToView {
    public func view(_ value: (Head.Value, Tail.Value)) -> some View {
        head.view(value.0)
        tail.view(value.1)
    }
}


extension Struct: RepresentationToView where Properties: RepresentationToView {
    public func view(_ value: Properties.Value) -> some View {
        VStack {
            Text(name).bold()
            properties.view(value)
        }
    }
}


extension Enum: RepresentationToView where Cases: RepresentationToView {
    public func view(_ value: Cases.Value) -> some View {
        HStack {
            Text(name).bold()
            cases.view(value)
        }
    }
}

extension Choice: RepresentationToView where First: RepresentationToView, Second: RepresentationToView {
    public func view(_ value: Either<First.Value, Second.Value>) -> some View {
        switch value {
        case .first(let l): first.view(l)
        case .second(let r): second.view(r)
        }
    }
}

extension Nothing: RepresentationToView {
    public func view(_ value: Nothing) -> some View {
    }
}

// primitive types

extension String: ToView {
    public var view: some View {
        Text(self)
    }
}

extension Date: ToView {
    public var view: some View {
        Text(self, format: .dateTime)
    }
}

extension Bool: ToView {
    public var view: some View {
        Text(self ? "yes" : "no")
    }
}

extension Structural where Structure: RepresentationToView {
    public var view: some View {
        Self.structure.view(to)
    }
}
