//
//  SignalText.swift
//  SignalsUI
//
//  Created by Martin Klöppner.
//

import Foundation
import SwiftUI
import Signals

public struct SText: View {
    
    @ObservedObject public var input: Signal<String>
    
    public init(input: Signal<String>) {
        self.input = input
    }
    
    public var body: some View {
        Text(self.input.value)
    }
    
}
