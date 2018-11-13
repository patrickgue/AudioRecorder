//
//  AudioControl.swift
//  AudioRecorder
//
//  Created by Patrick Günthard on 12.11.18.
//  Copyright © 2018 Patrick Günthard. All rights reserved.
//

import Foundation
import AVFoundation

class AudioControl:NSObject,AVAudioRecorderDelegate {
    
    
    
    var recorder:AVAudioRecorder?
    var path:URL
    
    init(path:URL) {
        self.path = path
        
        super.init()
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            recorder = try AVAudioRecorder(url: self.path, settings: settings)
            recorder?.delegate = self
            recorder?.isMeteringEnabled = true
            recorder?.prepareToRecord()
        } catch {
            print("Creation of AVAudioRecorder failed")
            print(error)
        }
    }
    
    
    func startRecord() {
        if(Int((recorder?.currentTime)!) > 0) {
            recorder?.record(atTime: (recorder?.currentTime)!)
        }
        else {
            recorder!.record()
        }
    }
    
    func pauseRecord() {
        recorder!.pause()
    }
    
    func stopRecord() {
        recorder!.stop()
    }
    
    func getTime() -> TimeInterval {
        return (recorder?.currentTime)!
    }
    
    func getValue() -> Float {
        recorder?.updateMeters()
        return (recorder?.averagePower(forChannel: 0))!
    }
}
