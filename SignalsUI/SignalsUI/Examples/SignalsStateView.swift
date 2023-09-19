//
//  ContentView.swift
//  SignalsUI
//
//  Created by Martin Klöppner.
//

import Signals
import SignalUI

import SwiftUI

struct SampleUser: Identifiable, Equatable, Hashable {
    public var id: Int
    public var username: String
}

var users: [SampleUser] = []

struct SignalsStateView: View {
    
    @ObservedObject private var input = MutableSignal("test")
    @ObservedObject private var model = MutableSignal<[SampleUser]>([])
    
    private var stepperValue$ = MutableSignal(0.3)
    
    init() {
        for idx in 0...100000 {
            users.append(SampleUser(id: idx, username: "User \(idx)"))
        }
        model.mutate(users)
    }
    
    var body: some View {
        
        VStack {
            SColorPicker(titleKey: Signal("test"), selection: MutableSignal(Color.black))
            STextField(Signal("Test"), text: input, prompt: Text("prompt"))
                .frame(width: nil, height: 50)
                .background(.green)
            ScrollViewReader { proxy in
                VStack {
                    List {
                        SForEach(model, id: Signal(\.id)) { user in
                            SText(input: computed(fn: { ctx in
                                return "Hello \(user.id) \(user.username) \(input.fn(ctx))"
                            }))
                        }
                        
                    }
                }.listStyle(.plain)
                    .onChange(of: model.value, perform: { newValue in
                        withAnimation() {
                            proxy.scrollTo(model.value.last)
                        }
                    })
                
            }
            SSlider(value: MutableSignal(5.5), in: MutableSignal((0...10.0))) {
                Text("label")
            } minimumValueLabel: {
                Text("min")
            } maximumValueLabel: {
                Text("max")
            }
            SStepper(title: computed { ctx in "\(self.stepperValue$.fn(ctx))" }, stepperValue: self.stepperValue$, range: Signal((0...1)), step: Signal(0.1))

            Button("Regenerate users") {
                users = []
                for idx in 0...100 {
                    users.append(SampleUser(id: idx, username: "User \(idx)"))
                }
                model.mutate(users)
            }
        }
        .padding()
    }
    
}

struct SignalsStateView_Previews: PreviewProvider {
    static var previews: some View {
        SignalsStateView()
    }
}
