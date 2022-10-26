//
//  LogProtocol.swift
//  SwiftLog
//
//  Created by u7chan on 2022/10/26.
//

protocol LogProtocol {
    func d(_ tag: String, _ text: String)
    func i(_ tag: String, _ text: String)
    func w(_ tag: String, _ text: String)
    func e(_ tag: String, _ text: String)
}
