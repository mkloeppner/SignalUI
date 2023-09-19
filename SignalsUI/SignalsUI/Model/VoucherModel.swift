//
//  VoucherModel.swift
//  SignalsUI
//
//  Created by Martin Klöppner on 9/23/23.
//

import Foundation
import Signals
import SignalUI

public struct Voucher: Identifiable, Hashable, Equatable {
    public var id = UUID().uuidString
    public var voucherValue: Float
}

public class VoucherModel: SignalModel {
    
    public var voucher = MutableSignal<Voucher>(Voucher(voucherValue: 0.0))
    
}
