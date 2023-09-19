//
//  UserScreen.swift
//  SignalsUI
//
//  Created by Martin Klöppner on 9/21/23.
//

import Foundation
import SignalUI
import Signals
import SwiftUI

public struct UserScreen: View {
    
    @EnvironmentObject private var session: Signal<SessionState>
    @EnvironmentObject private var balanceModel: BalanceModel
    
    private var amount: MutableSignal<Float> = MutableSignal(0.0)
    
    private var currencyFormatter = NumberFormatter()
    
    init() {
        self.currencyFormatter.numberStyle = .currencyPlural
    }
    
    public var body: some View {
        createSignalUI { ctx in
            VStack {
                HStack {
                    Text("\(self.balanceModel.getBalance().fn(ctx))")
                        .padding([.horizontal])
                    Spacer()
                    Button("Logout") {
                        (self.session as? MutableSignal<SessionState>)? .mutate(SessionState())
                    }.padding(.horizontal)
                }   .padding(.bottom)
                Text("Transactions")
                    .padding().font(.title)
                List {
                    ForEach(self.balanceModel.transactions.value) { transaction in
                        HStack {
                            Text("Transaction:")
                                .multilineTextAlignment(.leading)
                            Text("\(self.currencyFormatter.string(from: NSNumber(value: transaction.amount))!)")
                                .frame(width: 200)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }.listStyle(.plain)
                HStack {
                    TextField("amount", value: ReadWriteBinding(self.amount).fn(), formatter: NumberFormatter())
                        .autocapitalization(.none)
                        .id("amount")
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 2)
                        }
                    Text("$")
                    Button("PayIn") {
                        self.balanceModel.payIn(self.amount.value)
                    }
                }.padding([.leading, .trailing])
                Spacer()
                if let user = self.session.fn(ctx).user {
                    Text("Year of birth")
                    TextField("Birth",
                              value:ReadWriteBinding<Int>(user.birthdate).fn(),
                              formatter: NumberFormatter())
                    .autocapitalization(.none)
                    .id("birth")
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    }
                    .padding([.leading, .trailing, .bottom])
                }
            }
        }
    }
    
}
