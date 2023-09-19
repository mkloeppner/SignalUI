//
//  SignalsUIApp.swift
//  SignalsUI
//
//  Created by Martin Klöppner.
//

import SwiftUI
import Signals
import SignalUI

@main
struct SignalsUIApp: App {
    
    @StateObject private var session: Signal<SessionState> = MutableSignal(SessionState(isLoggedIn: true, user: User(id: "a", username: "a", birthdate: MutableSignal(1990))))
    @StateObject private var balanceModel: BalanceModel = BalanceModel()
    
    var body: some Scene {
        WindowGroup {
            TabView() {
                NavigationView {
                    HomeScreen()
                }.tabItem {
                    Image(systemName: "house.circle.fill")
                    Text("Home")
                }
                NavigationView {
                    createSignalUI { ctx in
                        if !self.session.fn(ctx).isLoggedIn {
                            LoginScreen()
                        } else {
                            UserScreen()
                        }
                    }
                }.tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Account")
                }
            }
            .environmentObject(session)
            .environmentObject(balanceModel)
        }
    }
}
