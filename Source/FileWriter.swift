//
//  FileWriter.swift
//  SwiftLog
//
//  Created by u7chan on 2022/10/26.
//

import Foundation

final class FileWriter {
    static func write(fileName: String, text: String) throws -> String {
        if fileName.isEmpty {
            return ""
        }

        let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = directory.filePathAppend(path: fileName)

        guard let stream = OutputStream(toFileAtPath: filePath, append: true),
              let textData = "\(text)\n".data(using: .utf8) else { return "" }

        stream.open()
        textData.withUnsafeBytes { (ptr: UnsafeRawBufferPointer) in
            if let address = ptr.baseAddress {
                stream.write(address, maxLength: textData.count)
            }
        }
        stream.close()

        return filePath
    }
}

private extension String {
    func filePathAppend(path: String) -> String {
        let nsstr = self as NSString
        return nsstr.appendingPathComponent(path)
    }
}
