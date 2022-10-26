//
//  FileLog.swift
//  SwiftLog
//
//  Created by u7chan on 2022/10/26.
//

import Foundation

public final class FileLog: LogProtocol {
    private let logFileName: String
    private let logDateFormatter: (() -> String)?

    init(
        logFileName: String,
        logDateFormatter: (() -> String)? = nil
    ) {
        self.logFileName = logFileName
        self.logDateFormatter = logDateFormatter
    }

    func d(_ tag: String, _ text: String) {
        LogCore.write(
            tag: tag,
            text: text,
            logLevel: .debug,
            dateFormatter: logDateFormatter
        ) { _ in
            // TODO:
        }
    }

    func i(_ tag: String, _ text: String) {
        LogCore.write(
            tag: tag,
            text: text,
            logLevel: .info,
            dateFormatter: logDateFormatter
        ) { _ in
            // TODO:
        }
    }

    func w(_ tag: String, _ text: String) {
        LogCore.write(
            tag: tag,
            text: text,
            logLevel: .warn,
            dateFormatter: logDateFormatter
        ) { _ in
            // TODO:
        }
    }

    func e(_ tag: String, _ text: String) {
        LogCore.write(
            tag: tag,
            text: text,
            logLevel: .error,
            dateFormatter: logDateFormatter
        ) { _ in
            // TODO:
        }
    }
}
