//
//  SignalText.swift
//  SignalsUI
//
//  Created by Martin Klöppner.
//

import Foundation
import SwiftUI
import Signals

struct SText: View {
    
    @ObservedObject public var input: Signal<String>
    
    init(input: Signal<String>) {
        self.input = input
    }
    
    var body: some View {
        Text(self.input.value)
    }
    
}
