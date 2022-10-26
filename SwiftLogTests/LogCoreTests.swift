//
//  LogCoreTests.swift
//  SwiftLogTests
//
//  Created by u7can on 2022/10/26.
//

@testable import SwiftLog
import XCTest

final class LogCoreTests: XCTestCase {
    func test_write_debug() {
        LogCore.write(tag: "#TAG", text: "#ANY", logLevel: .debug, dateFormatter: {
            "1970-01-02 13:14:15.678"
        }) { formattedText in
            XCTAssertEqual("1970-01-02 13:14:15.678 [DEBUG] #TAG #ANY", formattedText)
        }
    }

    func test_write_info() {
        LogCore.write(tag: "#TAG", text: "#ANY", logLevel: .info, dateFormatter: {
            "1980-01-02 13:14:15.678"
        }) { formattedText in
            XCTAssertEqual("1980-01-02 13:14:15.678 [INFO ] #TAG #ANY", formattedText)
        }
    }

    func test_write_warn() {
        LogCore.write(tag: "#TAG", text: "#ANY", logLevel: .warn, dateFormatter: {
            "1990-01-02 13:14:15.678"
        }) { formattedText in
            XCTAssertEqual("1990-01-02 13:14:15.678 [WARN ] #TAG #ANY", formattedText)
        }
    }

    func test_write_error() {
        LogCore.write(tag: "#TAG", text: "#ANY", logLevel: .error, dateFormatter: {
            "2000-01-02 13:14:15.678"
        }) { formattedText in
            XCTAssertEqual("2000-01-02 13:14:15.678 [ERROR] #TAG #ANY", formattedText)
        }
    }
}
