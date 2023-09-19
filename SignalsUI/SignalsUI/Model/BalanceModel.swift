//
//  BalanceModel.swift
//  SignalsUI
//
//  Created by Martin Klöppner on 9/21/23.
//

import Foundation
import Signals
import SignalUI
import SwiftUI

public struct Transaction: Identifiable, Equatable, Hashable {
    public var id: Int
    public var amount: Float
    public var timestamp = Date.now
}

public class BalanceModel: SignalModel {
    
    @PublishedObject public var voucherModel = VoucherModel()
    
    private var numberFormatter = NumberFormatter()
    
    public override init() {
        self.numberFormatter.numberStyle = .currency
        super.init()
    }
    
    public var transactions = MutableSignal<[Transaction]>([Transaction(id: 0, amount: 50), Transaction(id: 1, amount: -120.0)])
    
    public func payIn(_ amount: Float) {
        // TODO, some call ... some flow
        var transactions = self.transactions.value
        transactions.append(Transaction(id: transactions.count, amount: amount))
        self.transactions.mutate(transactions)
    }
    
    public func getBalance() -> Signal<String> {
        return computed { ctx in
            var totalAmount: Float = 0.0
            for transaction in self.transactions.fn(ctx) {
                totalAmount = totalAmount + transaction.amount
            }
            totalAmount = totalAmount + self.voucherModel.voucher.fn(ctx).voucherValue
            return self.numberFormatter.string(from: NSNumber(value: totalAmount))!
        }
    }
    
}
