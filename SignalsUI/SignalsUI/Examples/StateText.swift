//
//  StateText.swift
//  SignalsUI
//
//  Created by Martin Klöppner.
//

import Foundation

import Foundation
import SwiftUI

struct StateText: View {
    
    @EnvironmentObject public var data: Data
    
    var body: some View {
        Text(self.data.input)
    }
    
}
