//
//  AppModel.swift
//  SignalsUI
//
//  Created by Martin Klöppner.
//

import Foundation
import Signals
import SwiftUI

public class User: ObservableObject {
    @Published public var id: String
    @Published public var username: String
    public var birthdate: MutableSignal<Int>
    
    init(id: String, username: String, birthdate: MutableSignal<Int>) {
        self.id = id
        self.username = username
        self.birthdate = birthdate
    }
}

public struct SessionState {
    public var isLoggedIn = false
    public var user: User? = nil
}
