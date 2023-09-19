//
//  SignalModel.swift
//  
//
//  Created by Martin Klöppner.
//

import Foundation
import Signals

open class SignalModel: ObservableObject {
    
   public init() {
        let mirror = Mirror(reflecting: self)
        mirror.children.forEach { child in
            if let child = child.value as? (any Observable) {
                effect { ctx in
                    _ = child.fn(ctx)
                    self.objectWillChange.send()
                }
            }
        }
    }
    
}
