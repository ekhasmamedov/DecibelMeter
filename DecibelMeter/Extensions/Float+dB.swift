//
//  Float+dB.swift
//  DecibelMeter
//
//  Created by Eldar Khasmamedov on 2021-12-02.
//

import Foundation

extension Float {
    var decibelValueFormat: String {
        return String(format: "%.1f dB", self * 100)
    }
}
