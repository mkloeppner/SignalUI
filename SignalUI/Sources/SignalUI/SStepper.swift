//
//  SStepper.swift
//  
//
//  Created by Martin Klöppner on 9/19/23.
//

import Foundation
import Signals
import SwiftUI

public struct SStepper<T>: View where T: Strideable {
    @ObservedObject public var title: Signal<String>
    @ObservedObject public var stepperValue: MutableSignal<T>
    @ObservedObject public var range: Signal<ClosedRange<T>>
    @ObservedObject public var step: Signal<T.Stride>
    
    public init(title: Signal<String>, stepperValue: MutableSignal<T>, range: Signal<ClosedRange<T>>, step: Signal<T.Stride>) {
        self.title = title
        self.stepperValue = stepperValue
        self.range = range
        self.step = step
    }
    
    public var body: some View {
        Stepper(self.title.value, value: ReadWriteBinding(self.stepperValue).binding, in: self.range.value, step: self.step.value)
    }
}
