//
//  STextEditor.swift
//  
//
//  Created by Martin Klöppner on 9/19/23.
//

import Foundation

import Foundation
import SwiftUI
import Signals

public struct STextEditor: View {

    @ObservedObject public var input: MutableSignal<String>
    
    public init(input: MutableSignal<String>) {
        self.input = input
    }
    
    public var body: some View {
        TextEditor(text: ReadWriteBinding(self.input).binding)
    }
    
}
