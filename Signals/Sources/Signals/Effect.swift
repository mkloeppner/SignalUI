//
//  Effect.swift
//  
//
//  Created by Martin Klöppner.
//

import Foundation

/**
 * A effect context holds a closure that is called every time a signals within that closure changes
 */
internal class EffectContext : Context {
    internal var signal: Signal<Void>!
    internal var isUpdating = false
    
    internal var fn: (_ ctx: Context) -> Void
    
    init(fn: @escaping (_: Context) -> Void) {
        self.fn = fn
        self.signal = Signal<Void>(fn(self))
    }
    
    func update() {
        if !self.isUpdating {
            self.signal?.value = self.fn(self)
            self.isUpdating = true
        }
    }
    
    func updated() {
        self.isUpdating = false
    }
}

/**
 * Creates an effect that triggers every time a signal within the closure changes
 */
public func effect(fn: @escaping (_ ctx: Context) -> Void) -> Void {
    _ = EffectContext(fn: fn)
}
