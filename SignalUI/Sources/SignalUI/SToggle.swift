//
//  SToggle.swift
//  
//
//  Created by Martin Klöppner on 9/19/23.
//

import Foundation
import SwiftUI
import Signals

public struct SToggle: View {
    
    @ObservedObject public var title: Signal<String>
    @ObservedObject public var toggle: MutableSignal<Bool>
    
    public init(title: Signal<String>, isOn toggle: MutableSignal<Bool>) {
        self.title = title
        self.toggle = toggle
    }
    
    public var body: some View {
        Toggle(self.title.value, isOn: ReadWriteBinding(self.toggle).binding)
    }
    
}

