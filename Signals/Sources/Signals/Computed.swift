//
//  Computed.swift
//  
//
//  Created by Martin Klöppner.
//

import Foundation

/**
 * A computed context holds a closure that returns a value that is recalculated every time signals within that closure change.
 */
internal class ComputedContext<T>: Context where T: Equatable {
    /**
     * A signal created for the computed closure to notify observers of the computed property
     */
    internal var signal: Signal<T>!
    
    /**
     * The closure that needs to be run every time a signal of the closure changed
     */
    internal var fn: (_ ctx: any Context) -> T
    
    init(fn: @escaping (_: any Context) -> T) {
        self.fn = fn
        self.signal = Signal<T>(self.fn(self))
    }
    
    /**
     * Recalculates the value of the computed signal upon notification and notifies parent contexts to recalculate too
     */
    internal func update()  {
        // Reruns the closure with the latest updated signal values
        let newValue = self.fn(self)
        self.signal.update(newValue);
    }
    
    func updated() {
        
    }
}

/**
 * Creates a computed signal that updates every time a signal used inside the closure changes.
 */
public func computed<T>(fn: @escaping (_ ctx: Context) -> T) -> Signal<T> where T: Equatable {
    let ctx = ComputedContext<T>(fn: fn)
    return ctx.signal
}
