//
//  RecordingService.swift
//  DecibelMeter
//
//  Created by Eldar Khasmamedov on 2021-12-01.
//

import Foundation
import AVFoundation
import Combine

class RecordingService: ObservableObject {
    let audioEngine = AVAudioEngine()
    let currentValueSubject = CurrentValueSubject<Float, Never>(0)
    
    func startRecording() {
        let node = audioEngine.inputNode
        let format = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0,
                        bufferSize: 1024,
                        format: format) { [weak self] buffer, _ in
            guard let self = self else { return }
            let volume = self.getVolume(from: buffer)
            self.currentValueSubject.send(volume)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        }
        catch {
            print("Audio Engine failed to start")
        }
    }
    
    private func getVolume(from buffer: AVAudioPCMBuffer) -> Float {
        guard let channelData = buffer.floatChannelData else {
            return 0
        }
        
        let channelDataValue = channelData.pointee
        
        let channelDataValueArray = stride(
            from: 0,
            to: Int(buffer.frameLength),
            by: buffer.stride)
            .map { channelDataValue[$0] }
        
        let rms = sqrt(channelDataValueArray.map {
            return $0 * $0
        }
        .reduce(0, +) / Float(buffer.frameLength))
         
        let avgPower = 20 * log10(rms)
        
        let dbValue = avgPower + 80
        return dbValue
    }
}
