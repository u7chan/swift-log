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

// Test Utils

private func readFileText(_ filePath: String) -> String {
    return try! String(contentsOfFile: filePath, encoding: .utf8)
}

private func cleanupLogs() {
    let ext = ".log"
    let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let fileManager = FileManager.default
    let items = try! fileManager.contentsOfDirectory(atPath: directory)
    for item in items {
        if !item.hasSuffix(ext) {
            continue
        }
        let filePath = "\(directory)/\(item)"
        print("Found Log: \(filePath)")
        try! fileManager.removeItem(atPath: filePath)
    }
}
