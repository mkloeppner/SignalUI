//
//  ReadWriteBinding.swift
//  
//
//  Created by Martin Klöppner.
//

import Foundation
import SwiftUI
import Signals

public class ReadWriteBinding<T>: SignalBinding {
    typealias T = T
    
    private(set) var binding: Binding<T>
    
    public init(_ signal: MutableSignal<T>) {
        self.binding = Binding<T>(get: {
            return signal.value
        }, set: { value, tx in
            signal.mutate(value)
        })
    }
    
    public func fn() -> Binding<T> {
        return self.binding
    }
}
