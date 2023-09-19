//
//  STextField.swift
//  SignalsUI
//
//  Created by Martin Klöppner.
//

import Foundation
import SwiftUI
import Signals

public struct STextField: View {
    
    @ObservedObject private var title: Signal<String>
    @ObservedObject public var text: MutableSignal<String>
    public var prompt: Text
    
    public init(_ title: Signal<String>, text: MutableSignal<String>, prompt: Text) {
        self.title = title
        self.text = text
        self.prompt = prompt
    }
    
    public var body: some View {
        if #available(iOS 15.0, *) {
            TextField(self.title.value, text: ReadWriteBinding(self.text).binding, prompt: prompt)
        } else {
            // Fallback on earlier versions
        }
    }
    
}
