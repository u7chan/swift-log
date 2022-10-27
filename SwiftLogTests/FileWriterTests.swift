//
//  FileWritterTests.swift
//  SwiftLogTests
//
//  Created by u7can on 2022/10/26.
//

@testable import SwiftLog
import XCTest

final class FileWriterTests: XCTestCase {
    override func setUp() {
        cleanupLogs()
    }

    func test_write() throws {
        let actualFilePath = try FileWriter.write(fileName: "example.log", text: "Hello")
        XCTAssertEqual(true, actualFilePath.hasSuffix("/data/Documents/example.log"))
        XCTAssertEqual("Hello\n", readFileText(actualFilePath))
    }

    func test_write_two_line() throws {
        let actualFilePath = try FileWriter.write(fileName: "example.log", text: "Hello")
        _ = try FileWriter.write(fileName: "example.log", text: "Goodbye")
        XCTAssertEqual(true, actualFilePath.hasSuffix("/data/Documents/example.log"))
        XCTAssertEqual("Hello\nGoodbye\n", readFileText(actualFilePath))
    }

    func test_write_text_empty() throws {
        let actualFilePath = try FileWriter.write(fileName: "example.log", text: "")
        XCTAssertEqual(true, actualFilePath.hasSuffix("/data/Documents/example.log"))
        XCTAssertEqual("\n", readFileText(actualFilePath))
    }

    func test_write_filename_empty() throws {
        let actualFilePath = try FileWriter.write(fileName: "", text: "Hello")
        XCTAssertEqual("", actualFilePath)
    }
}
