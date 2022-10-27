//
//  FileLogTests.swift
//  SwiftLogTests
//
//  Created by u7can on 2022/10/26.
//

@testable import SwiftLog
import XCTest

final class FileLogTests: XCTestCase {
    override func setUp() {
        cleanupLogs()
    }

    func test_log_debug() {
        FileLog(logFileName: "example.log", logDateFormatter: { "<DATE>" }).d("#TAG", "#DEBUG")
        XCTAssertEqual("<DATE> [DEBUG] #TAG #DEBUG\n", readFileText(createDocumentPath("example.log")))
    }

    func test_log_info() {
        FileLog(logFileName: "example.log", logDateFormatter: { "<DATE>" }).i("#TAG", "#INFO")
        XCTAssertEqual("<DATE> [INFO ] #TAG #INFO\n", readFileText(createDocumentPath("example.log")))
    }

    func test_log_warn() {
        FileLog(logFileName: "example.log", logDateFormatter: { "<DATE>" }).w("#TAG", "#WARN")
        XCTAssertEqual("<DATE> [WARN ] #TAG #WARN\n", readFileText(createDocumentPath("example.log")))
    }

    func test_log_error() {
        FileLog(logFileName: "example.log", logDateFormatter: { "<DATE>" }).e("#TAG", "#ERROR")
        XCTAssertEqual("<DATE> [ERROR] #TAG #ERROR\n", readFileText(createDocumentPath("example.log")))
    }
}
