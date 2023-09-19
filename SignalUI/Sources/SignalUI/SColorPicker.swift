//
//  SColorPicker.swift
//  
//
//  Created by Martin Klöppner on 9/19/23.
//

import Foundation
import SwiftUI
import Signals

public struct SColorPicker: View {
    
    @ObservedObject public var titleKey: Signal<LocalizedStringKey>
    @ObservedObject public var selection: MutableSignal<Color>
    
    public init(titleKey: Signal<LocalizedStringKey>, selection: MutableSignal<Color>) {
        self.titleKey = titleKey
        self.selection = selection
    }
    
    public var body: some View {
        ColorPicker(self.titleKey.value, selection: ReadWriteBinding(self.selection).binding)
    }
    
}
