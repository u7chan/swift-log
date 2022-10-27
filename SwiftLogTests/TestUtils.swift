//
//  TestUtils.swift
//  SwiftLogTests
//
//  Created by u7can on 2022/10/27.
//

import Foundation

func readFileText(_ filePath: String) -> String {
    return try! String(contentsOfFile: filePath, encoding: .utf8)
}

func cleanupLogs() {
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

func createDocumentPath(_ fileName: String) -> String {
    let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    return "\(directory)/\(fileName)"
}
