import XCTest
@testable import Signals

final class TestContext: Context {
    var _update: Int = 0
    var _updated: Int = 0
    func update() {
        self._update += 1
    }
    
    func updated() {
        self._updated += 1
    }
    
}

final class TestTransaction: Transaction {
    var modifications: [() -> Void] = []
    
    var updates: [() -> Void] = []
    
    var finished: [() -> Void] = []
}

struct User {
    let username: String
    let password: String
}

final class SignalsTests: XCTestCase {
    
    public func testA() {
    }   
    
    
}
