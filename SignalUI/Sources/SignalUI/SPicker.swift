//
//  SPicker.swift
//  
//
//  Created by Martin Klöppner.
//

import Foundation
import SwiftUI
import Signals

public struct SPicker<SelectionValue, Content, Label>: View where Label: View, Content: View, SelectionValue: Hashable {
    
    @ObservedObject public var selection: MutableSignal<SelectionValue>
    @ViewBuilder var content: () -> Content
    @ViewBuilder var label: () -> Label
    
    public init(selection: MutableSignal<SelectionValue>, @ViewBuilder content: @escaping () -> Content, @ViewBuilder label: @escaping () -> Label) {
        self.selection = selection
        self.content = content
        self.label = label
    }
    
    public var body: some View {
        Picker(selection: ReadWriteBinding(self.selection).binding, content: self.content, label: self.label)
    }
}
