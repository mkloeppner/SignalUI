//
//  PublishedObject.swift
//  
//
//  Created by Martin Klöppner on 9/23/23.
//

import Foundation
import Combine
import Foundation

@propertyWrapper
public struct PublishedObject<Value> {
    
    private class PreviousPublishedObject {
        var objectWillChange: (() -> Void)?
        init() {}
    }

    private lazy var _value = CurrentValueSubject<Value, Never>(wrappedValue)
    public var value: Publisher {
        mutating get {
            _value.eraseToAnyPublisher()
        }
    }
    public var wrappedValue: Value {
        
        willSet {
            previous.objectWillChange?()
        }
        
        didSet {
            observe(to: wrappedValue)
        }
        
    }
    
    private let previous = PreviousPublishedObject()
    private var previousObserver: AnyCancellable?
    private var _startObservation: (inout Self, _ toValue: Value) -> Void
    private mutating func observe(to wrappedValue: Value) {
        _startObservation(&self, wrappedValue)
    }
    
    public typealias Publisher = AnyPublisher<Value, Never>
    
    public init(wrappedValue: Value) where Value: ObservableObject, Value.ObjectWillChangePublisher == ObservableObjectPublisher {
        self.previousObserver = nil
        self.wrappedValue = wrappedValue
        _startObservation = { _promise, _value in
            let parentValue = _promise._value
            let parent = _promise.previous
            _promise.previousObserver = _value.objectWillChange.sink { [parent] in
                parent.objectWillChange?()
                parentValue.send(_value)
            }
            parentValue.send(_value)
        }
        observe(to: wrappedValue)
    }
    
    public init<T>(wrappedValue: T?) where T? == Value, T: ObservableObject, T.ObjectWillChangePublisher == ObservableObjectPublisher {
        self.previousObserver = nil
        self.wrappedValue = wrappedValue
        _startObservation = { _promise, _value in
            let parentValue = _promise._value
            let parent = _promise.previous
            _promise.previousObserver = _value?.objectWillChange.sink { [parent] in
                parent.objectWillChange?()
                parentValue.send(_value)
            }
            parentValue.send(_value)
        }
        observe(to: wrappedValue)
    }
    
    public static subscript<This: ObservableObject>(
        _enclosingInstance observed: This,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<This, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<This, PublishedObject>
    ) -> Value where This.ObjectWillChangePublisher == ObservableObjectPublisher {
        get {
            observed[keyPath: storageKeyPath]
                .setParent(observed)
            return observed[keyPath: storageKeyPath]
                .wrappedValue
        }
        set {
            observed[keyPath: storageKeyPath]
                .wrappedValue = newValue
            observed[keyPath: storageKeyPath]
                .setParent(observed)
        }
    }
    
    public static subscript<This: ObservableObject>(
        _enclosingInstance observed: This,
        projected wrappedKeyPath: KeyPath<This, Publisher>,
        storage storageKeyPath: ReferenceWritableKeyPath<This, PublishedObject>
    ) -> Publisher where This.ObjectWillChangePublisher == ObservableObjectPublisher {
        observed[keyPath: storageKeyPath].setParent(observed)
        return observed[keyPath: storageKeyPath].value
    }

    private func setParent<Parent: ObservableObject>(_ parentObject: Parent) where Parent.ObjectWillChangePublisher == ObservableObjectPublisher {
        if previous.objectWillChange != nil {
            return
        }
        previous.objectWillChange = { [weak parentObject] in
            parentObject?.objectWillChange.send()
        }
    }
}

extension Published where Value: ObservableObject {
    public init(wrappedValue: Value) {
        fatalError("Use PublishedObject with ObservableObjects")
    }
}
