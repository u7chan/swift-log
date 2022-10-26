//
//  ConsoleLogTests.swift
//  SwiftLogTests
//
//  Created by u7chan on 2022/10/26.
//

@testable import SwiftLog
import XCTest

final class ConsoleLogTests: XCTestCase {
    func test_log_debug() {
        ConsoleLog().d("#TAG", "#DEBUG")
    }

    func test_log_info() {
        ConsoleLog().i("#TAG", "#INFO")
    }

    func test_log_warn() {
        ConsoleLog().w("#TAG", "#WARN")
    }

    func test_log_error() {
        ConsoleLog().e("#TAG", "#ERROR")
    }
}
