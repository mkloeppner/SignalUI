//
//  SSecureField.swift
//  
//
//  Created by Martin Klöppner.
//

import Foundation
import SwiftUI
import Signals

public struct SSecureField: View {
    
    @ObservedObject public var title: Signal<String>
    @ObservedObject public var input: MutableSignal<String>
    
    public init(title: Signal<String>, input: MutableSignal<String>) {
        self.title = title
        self.input = input
    }
    
    public var body: some View {
        SecureField(self.title.value, text: ReadWriteBinding(self.input).binding)
    }
    
}
