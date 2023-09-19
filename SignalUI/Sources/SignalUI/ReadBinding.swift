//
//  ReadBinding.swift
//  
//
//  Created by Martin Klöppner.
//

import Foundation
import SwiftUI
import Signals

public class ReadBinding<T>: SignalBinding {
    typealias T = T
    
    public private(set) var binding: Binding<T>
    
    public init(_ signal: Signal<T>) {
        self.binding = Binding<T>(get: {
            return signal.value
        }, set: { value, tx in
        })
    }
    
    public func `$`() -> Binding<T> {
        return self.binding
    }
}
