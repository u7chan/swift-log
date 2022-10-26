//
//  Log.swift
//  SwiftLog
//
//  Created by u7chan on 2022/10/26.
//

import Foundation

final class Log {
    private static let isFileWriteEnabled = true
    private static var fileURL: URL?
    private static let lockObj = NSObject()
    private static let dateFormatter = createFormatter("yyyy-MM-dd HH:mm:ss.SSS")
    private static let fileNameFormatter = createFormatter("yyyyMMdd")

    private enum Level: String {
        case debug = "[DEBUG]"
        case info = "[INFO ]"
        case warn = "[WARN ]"
        case error = "[ERROR]"
    }

    static func setup(_ fileName: String) -> String {
        guard let documentURL = FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .last
        else {
            return ""
        }
        fileURL = documentURL.appendingPathComponent(fileName)

        return fileURL?.absoluteString ?? ""
    }

    static func d(_ msg: String) {
        execute(msg, .debug)
    }

    static func i(_ msg: String) {
        execute(msg, .info)
    }

    static func w(_ msg: String) {
        execute(msg, .warn)
    }

    static func e(_ msg: String) {
        execute(msg, .error)
    }

    static func raedAll() -> [String] {
        guard let data = read() else {
            return []
        }
        return data.components(separatedBy: "\n")
    }

    private static func execute(_ msg: String, _ level: Level) {
        if !isFileWriteEnabled {
            return
        }
        objc_sync_enter(lockObj)
        let message = format(msg, level)
        print(message) // コンソールに出力
        write(message) // ファイルに出力
        objc_sync_exit(lockObj)
    }

    private static func format(_ msg: String, _ level: Level) -> String {
        return "\(dateFormatter.string(from: Date())) \(level.rawValue) (App) \(msg)"
    }

    private static func createFilePath() -> URL? {
        guard let fileURL = fileURL else { return nil }
        let path = fileURL.path.removeExtension()
        let ext = fileURL.path.pathExtension
        let newPath = "\(path)_\(fileNameFormatter.string(from: Date())).\(ext)"
        return URL(fileURLWithPath: newPath)
    }

    private static func write(_ msg: String) {
        guard let fileURL = createFilePath() else { return }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            appendText(fileURL, msg)
        } else {
            createText(fileURL, msg)
        }
    }

    private static func read() -> String? {
        guard let fileURL = createFilePath() else { return nil }
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            return nil
        }
        do {
            let fileHandle = try FileHandle(forReadingFrom: fileURL)
            let data = fileHandle.readDataToEndOfFile()
            let dataString = String(data: data, encoding: .utf8)!
            try fileHandle.close()
            return dataString
        } catch {
            print("failed to read: \(error)")
        }
        return nil
    }

    private static func appendText(_ fileURL: URL, _ msg: String) {
        do {
            let fileHandle = try FileHandle(forWritingTo: fileURL)
            fileHandle.seekToEndOfFile()
            fileHandle.write(("\n" + msg).data(using: String.Encoding.utf8)!)
            try fileHandle.close()
        } catch {
            print("failed to append: \(error)")
        }
    }

    private static func createText(_ fileURL: URL, _ msg: String) {
        do {
            try msg.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("failed to write: \(error)")
        }
    }

    private static func createFormatter(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter
    }
}

private extension String {
    var pathExtension: String {
        return ns.pathExtension
    }

    func removeExtension() -> String {
        if pathExtension.isEmpty {
            return ""
        }
        return replace("." + pathExtension, "")
    }

    func replace(_ target: String, _ withString: String) -> String {
        return replacingOccurrences(
            of: target, with: withString, options: NSString.CompareOptions.literal, range: nil
        )
    }

    private var ns: NSString {
        return (self as NSString)
    }
}
