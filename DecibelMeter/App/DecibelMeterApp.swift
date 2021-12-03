//
//  DecibelMeterApp.swift
//  DecibelMeter
//
//  Created by Eldar Khasmamedov on 2021-12-01.
//

import SwiftUI

@main
struct DecibelMeterApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(RecordingService())
        }
    }
}
