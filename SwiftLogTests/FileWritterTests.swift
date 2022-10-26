//
//  FileWritterTests.swift
//  SwiftLogTests
//
//  Created by u7can on 2022/10/26.
//

@testable import SwiftLog
import XCTest

final class FileWritterTests: XCTestCase {
    func test_createDocumentPath() {
        let actual = FileWritter.createDocumentPath(fileName: "example.log")
        XCTAssertTrue(actual.hasSuffix("/data/Documents/example.log"))
    }
}
