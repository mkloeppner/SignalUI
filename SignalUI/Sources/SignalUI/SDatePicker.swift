//
//  SDatePicker.swift
//  
//
//  Created by Martin Klöppner on 9/19/23.
//

import Foundation
import SwiftUI
import Signals

public struct SDatePicker: View {
    
    @ObservedObject public var titleKey: Signal<LocalizedStringKey>
    @ObservedObject public var selection: MutableSignal<Date>
    
    public init(titleKey: Signal<LocalizedStringKey>, selection: MutableSignal<Date>) {
        self.titleKey = titleKey
        self.selection = selection
    }
    
    public var body: some View {
        DatePicker(self.titleKey.value, selection: ReadWriteBinding(self.selection).binding)
    }
    
}
