//
//  SignalBinding.swift
//  
//
//  Created by Martin Klöppner.
//

import Foundation
import Signals
import SwiftUI

protocol SignalBinding {
    associatedtype T
    var binding: Binding<T> { get }
}
