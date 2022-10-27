//
//  FileLog.swift
//  SwiftLog
//
//  Created by u7chan on 2022/10/26.
//

import Foundation

public final class FileLog: LogProtocol {
    private let showConsole: Bool
    private let logFileName: String
    private let logDateFormatter: (() -> String)?

    init(
        showConsole: Bool = true,
        logFileName: String,
        logDateFormatter: (() -> String)? = nil
    ) {
        self.showConsole = showConsole
        self.logFileName = logFileName
        self.logDateFormatter = logDateFormatter
    }

    func d(_ tag: String, _ text: String) {
        LogCore.write(
            tag: tag,
            text: text,
            logLevel: .debug,
            dateFormatter: logDateFormatter
        ) { formattedText in
            if showConsole {
                print(formattedText)
            }
            _ = try? FileWriter.write(fileName: logFileName, text: formattedText)
        }
    }

    func i(_ tag: String, _ text: String) {
        LogCore.write(
            tag: tag,
            text: text,
            logLevel: .info,
            dateFormatter: logDateFormatter
        ) { formattedText in
            if showConsole {
                print(formattedText)
            }
            _ = try? FileWriter.write(fileName: logFileName, text: formattedText)
        }
    }

    func w(_ tag: String, _ text: String) {
        LogCore.write(
            tag: tag,
            text: text,
            logLevel: .warn,
            dateFormatter: logDateFormatter
        ) { formattedText in
            if showConsole {
                print(formattedText)
            }
            _ = try? FileWriter.write(fileName: logFileName, text: formattedText)
        }
    }

    func e(_ tag: String, _ text: String) {
        LogCore.write(
            tag: tag,
            text: text,
            logLevel: .error,
            dateFormatter: logDateFormatter
        ) { formattedText in
            if showConsole {
                print(formattedText)
            }
            _ = try? FileWriter.write(fileName: logFileName, text: formattedText)
        }
    }
}
