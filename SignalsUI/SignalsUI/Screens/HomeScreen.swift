//
//  HomeScreen.swift
//  SignalsUI
//
//  Created by Martin Klöppner on 9/20/23.
//

import SwiftUI
import Signals
import SignalUI

struct HomeScreen: View {
    
    @EnvironmentObject private var session: Signal<SessionState>
    @EnvironmentObject private var balanceModel: BalanceModel
    
    var body: some View {
        Group {
            createSignalUI { ctx in
                if self.session.fn(ctx).isLoggedIn {
                    VStack {
                        Text("Logged In")
                        AgeView(age: self.calculateAge())
                        Text("Balance: \(self.balanceModel.getBalance().fn(ctx))")
                        Button("Add voucher") {
                            self.balanceModel.voucherModel.voucher.mutate(Voucher(voucherValue: 100.0))
                        }
                    }
                } else {
                    Text("Not logged in")
                }
            }
        }
    }
    
    func calculateAge() -> Signal<Int> {
        return computed { ctx in
            return (Calendar.current.dateComponents(in: .current, from: Date()).year ?? 0) - (self.session.fn(ctx).user?.birthdate.fn(ctx) ?? 0) }
    }
    
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
