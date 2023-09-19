//
//  SForEach.swift
//  
//
//  Created by Martin Klöppner on 9/19/23.
//

import Foundation
import Signals
import SwiftUI

public struct SForEach<Data, ID, Content>: View where Data : RandomAccessCollection, ID : Hashable, Content: View {
    
    @ObservedObject public var data: Signal<Data>
    @ObservedObject public var id: Signal<KeyPath<Data.Element, ID>>

    /// A function to create content on demand using the underlying data.
    public var content: (Data.Element) -> Content
    
    public init(_ data: Signal<Data>, id: Signal<KeyPath<Data.Element, ID>>, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.id = id
        self.content = content
    }
    
    public var body: some View {
        ForEach(self.data.value, id: self.id.value, content: self.content)
    }
}
