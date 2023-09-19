//
//  File.swift
//  
//
//  Created by Martin Klöppner on 9/19/23.
//

import XCTest
@testable import Signals

final class SignalTests: XCTestCase {
    
    func testSignalIntializesValue() throws {
        let signal = Signal("test")
        XCTAssertEqual(signal.value, "test")
    }
    
    func testSignalReadsValue() throws {
        let signal = Signal("test")
        let context = TestContext()
        let value = signal.fn(context)
        XCTAssertEqual(value, "test")
    }
    
    func testSignalSubscribesContextWhileReadingValue() throws {
        let signal = Signal("test")
        let context = TestContext()
        _ = signal.fn(context)
        XCTAssertEqual(signal.usedInCtxs.count, 1, "No context subscribed")
    }
    
    func testSignalSubscribesContextWhileReadingValueOnceOnly() throws {
        let signal = Signal("test")
        let context = TestContext()
        _ = signal.fn(context)
        _ = signal.fn(context)
        XCTAssertEqual(signal.usedInCtxs.count, 1, "No context subscribed")
    }
    
}
