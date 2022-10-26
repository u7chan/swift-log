//
//  FileWritter.swift
//  SwiftLog
//
//  Created by u7chan on 2022/10/26.
//

import Foundation

final class FileWritter {
    static func createDocumentPath(fileName: String) -> String {
        if let documentFilePath = FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .last?.appendingPathComponent(fileName).absoluteString
        {
            return documentFilePath
        }
        return ""
    }
}
