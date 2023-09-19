//
//  LoggedInHome.swift
//  SignalsUI
//
//  Created by Martin Klöppner on 9/21/23.
//

import Foundation
import Signals
import SignalUI
import SwiftUI

struct AgeView: View {
    
    @ObservedObject var age: Signal<Int>
    
    var body: some View {
        VStack {
            createSignalUI { ctx in
                Text("Age: \(self.age.fn(ctx))")
            }
        }
    }
    
}

struct LoggedInHome_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
