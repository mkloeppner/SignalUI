//
//  STextField.swift
//  SignalsUI
//
//  Created by Martin Klöppner.
//

import Foundation
import SwiftUI
import Signals

struct STextField: View {
    
    @ObservedObject public var input: MutableSignal<String>
    
    init(input: MutableSignal<String>) {
        self.input = input
    }
    
    var body: some View {
        TextField("test", text: Binding<String>(get: {
            return self.input.value
        }, set: { value, tx in
            self.input.mutate(value)
        }))
    }
    
}
