//
//  ContentView.swift
//  SignalsUI
//
//  Created by Martin Klöppner on 9/19/23.
//

import Signals

import SwiftUI

private let signal = MutableSignal("test")

struct ContentView: View {
    var body: some View {
        VStack {
            SText(input: computed(fn: { ctx in
                return "Hello \(signal.fn(ctx))"
            }))
            STextField(input: signal)
                .frame(width: .infinity, height: 50)
                .background(.green)
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("test", action: {
                signal.mutate("ys")
            })
        }
        .padding()
    }
    
    init() {
        signal.mutate("adda")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
