////
//
//import Foundation
//import SwiftUI
//
//public protocol Edit {
//    associatedtype E: View
//
//    @ViewBuilder
//    func edit(_ binding: Binding<Self>) -> E
//}
//
//extension Struct: Edit where Properties: Edit {
//    public func edit(_ binding: Binding<Struct<Properties>>) -> some View {
//        properties.edit(binding.properties)
//    }
//}
//
//extension Empty: Edit {
//    public func edit(_ binding: Binding<Empty>) -> some View {
//        EmptyView()
//    }
//}
//
//extension List: Edit where Head: Edit, Tail: Edit {
//    public func edit(_ binding: Binding<List<Head, Tail>>) -> some View {
//        head.edit(binding.head)
//        tail.edit(binding.tail)
//    }
//}
//
//extension Property: Edit where Value: EditPrimitive {
//    public func edit(_ binding: Binding<Property<Value>>) -> some View {
//        value.edit(title: .init(name), binding.value)
//    }
//}
//
//public protocol EditPrimitive {
//    associatedtype E: View
//
//    func edit(title: LocalizedStringKey, _ binding: Binding<Self>) -> E
//}
//
//extension String: EditPrimitive {
//    public func edit(title: LocalizedStringKey, _ binding: Binding<String>) -> some View {
//        TextField(title, text: binding)
//    }
//}
//
//extension Bool: EditPrimitive {
//    public func edit(title: LocalizedStringKey, _ binding: Binding<Bool>) -> some View {
//        Toggle(title, isOn: binding)
//    }
//}
//
//extension Date: EditPrimitive {
//    public func edit(title: LocalizedStringKey, _ binding: Binding<Date>) -> some View {
//        DatePicker(title, selection: binding)
//    }
//}
//
//extension Structural {
//    var structure: Structure {
//        get { to }
//        set { self = .from(newValue) }
//    }
//}
//
//extension Structural where Structure: Edit {
//    public func edit(_ binding: Binding<Self>) -> some View {
//        to.edit(binding.structure)
//    }
//}
