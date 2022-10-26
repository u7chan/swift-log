//
//  LogCore.swift
//  SwiftLog
//
//  Created by u7chan on 2022/10/26.
//

import Foundation

final class LogCore {
    private static let lockObj = NSObject()
    private static let defaultDateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter.string(from: Date())
    }

    static func write(
        tag: String,
        text: String,
        logLevel: LogLevel,
        dateFormatter: (() -> String)?,
        output: (_ formattedText: String) -> Void
    ) {
        objc_sync_enter(lockObj)
        let formattedText = logFormat(
            tag: tag,
            text: text,
            logLevel: logLevel,
            dateFormatter: dateFormatter ?? defaultDateFormatter
        )
        output(formattedText)
        objc_sync_exit(lockObj)
    }

    private static func logFormat(
        tag: String,
        text: String,
        logLevel: LogLevel,
        dateFormatter: () -> String
    ) -> String {
        return "\(dateFormatter()) \(logLevel.rawValue) \(tag) \(text)"
    }
}
