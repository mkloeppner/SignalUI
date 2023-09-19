import Signals
import SwiftUI

public struct SignalUI {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

protocol ViewContext {
    associatedtype V: View

    var signal: Signal<V>! { get set }
}

internal class SwiftUIEffectContext<T> : Context, ViewContext where T: View {
    typealias V = T
    
    internal var signal: Signal<T>!
    internal var isUpdating = false
    
    internal var fn: (_ ctx: Context) -> T
    
    init(fn: @escaping (_: Context) -> T) {
        self.fn = fn
        self.signal = Signal<T>(fn(self))
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
@ViewBuilder public func createSignalUI(@ViewBuilder fn: @escaping (Context) -> some View) -> some View  {
    let context = SwiftUIEffectContext { ctx in
        fn(ctx)
    }
    context.signal.fn(context)
}
