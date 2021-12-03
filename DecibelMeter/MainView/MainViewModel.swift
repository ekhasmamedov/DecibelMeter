//
//  MainViewModel.swift
//  DecibelMeter
//
//  Created by Eldar Khasmamedov on 2021-12-01.
//

import Foundation
import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var decibelText: String = "0 dB"
    
    private var recordingService: RecordingService?
    
    func onAppear(recordingService: RecordingService) {
        self.recordingService = recordingService
        startRecording()
    }
    
    func startRecording() {
        recordingService?.currentValueSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                print("Should Never Complete")
            }, receiveValue: { [weak self] value in
                self?.decibelText = value.decibelValueFormat
            })
            .store(in: &cancellables)
        
        recordingService?.startRecording()
    }
}
