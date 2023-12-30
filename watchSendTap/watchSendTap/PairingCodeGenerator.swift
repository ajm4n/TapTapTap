//
//  PairingCodeGenerator.swift
//  watchSendTap
//
//  Created by ajman on 12/12/23.
//

import Foundation

class PairingCodeGenerator {
    static func generateCode() -> String {
        let code = String((0..<6).map { _ in "0123456789".randomElement()! })
        return code
    }
}
