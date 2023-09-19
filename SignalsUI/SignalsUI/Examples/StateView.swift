//
//  StateView.swift
//  SignalsUI
//
//  Created by Martin Klöppner.
//

import Signals

import SwiftUI

class Data: ObservableObject {
    @Published public var input = "test"
}

struct StateView: View {
    
    @StateObject private var data: Data = Data()
    
    var body: some View {
        VStack {
            TextField("test", text: self.$data.input)
                .frame(width: .infinity, height: 50)
                .background(.green)
            List {
                ForEach((1...100000), id: \.self) { ifx in
                    StateText()
                }
            }.listStyle(.plain)
        }
        .padding().environmentObject(self.data)
    }
}

struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        SignalsStateView()
    }
}

