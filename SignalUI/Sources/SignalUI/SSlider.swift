//
//  SSlider.swift
//  
//
//  Created by Martin Klöppner on 9/19/23.
//

import Foundation
import SwiftUI
import Signals

public struct SSlider<Label, ValueLabel>: View where Label: View, ValueLabel: View {
    
    @ObservedObject public var sliderValue: MutableSignal<Float>
    @ObservedObject public var sliderRange: MutableSignal<ClosedRange<Float>>
    @ViewBuilder var minimumValueLabel: () -> ValueLabel
    @ViewBuilder var maximumValueLabel: () -> ValueLabel
    @ViewBuilder var label: () -> Label
    
    public init(value: MutableSignal<Float>, in sliderRange: MutableSignal<ClosedRange<Float>>,label: @escaping () -> Label, minimumValueLabel: @escaping () -> ValueLabel, maximumValueLabel: @escaping () -> ValueLabel) {
        self.sliderValue = value
        self.sliderRange = sliderRange
        self.minimumValueLabel = minimumValueLabel
        self.maximumValueLabel = maximumValueLabel
        self.label = label
    }

    
    public var body: some View {
        Slider<Label, ValueLabel>(value: ReadWriteBinding(self.sliderValue).binding, in: self.sliderRange.value, minimumValueLabel: self.minimumValueLabel(), maximumValueLabel: self.maximumValueLabel(), label: self.label)
    }
    
}
