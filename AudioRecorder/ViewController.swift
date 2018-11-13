//
//  ViewController.swift
//  AudioRecorder
//
//  Created by Patrick Günthard on 12.11.18.
//  Copyright © 2018 Patrick Günthard. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var audioControl:AudioControl?
    var isRecording:Bool = false
    var timer:DispatchSourceTimer?
    
    @IBOutlet var openButton:NSButton!
    @IBOutlet var recordButton:NSButton!
    @IBOutlet var pauseButton:NSButton!
    @IBOutlet var stopButton:NSButton!
    
    @IBOutlet var timeLabel:NSTextField!
    @IBOutlet var fileLabel:NSTextField!
    
    @IBOutlet var audioMeter:AudioMeter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func setPath(_ sender: Any) {
        print("Set Path")
        let panel = NSSavePanel()
        panel.allowedFileTypes = ["m4a", "aac"]
        
        let choice = panel.runModal()
        
        switch(choice) {
        case .OK :
            self.audioControl = AudioControl(path:panel.url!)
            self.recordButton.isEnabled = true
            self.openButton.isEnabled = false
            self.fileLabel.stringValue = (panel.url?.lastPathComponent)!
            break;
        case .cancel :
            print("canceled")
            break;
        default:
            print("test")
            break;
        }
    }

    @IBAction func startRecording(_ sender: Any) {
        if(self.recordButton.isEnabled) {
            print("start recording")
            self.pauseButton.isEnabled = true
            self.stopButton.isEnabled = true
            self.recordButton.isEnabled = false
            self.audioControl?.startRecord()
            isRecording = true
            setupUpdateMeter()
        }
        else {
            print("recording not possible. no file loaded")
        }
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        if(self.stopButton.isEnabled){
            self.audioControl?.stopRecord()
            self.pauseButton.isEnabled = false
            self.stopButton.isEnabled = false
            self.recordButton.isEnabled = false
            self.openButton.isEnabled = true
            self.timer?.cancel()
            self.audioMeter.decibel = -120
            self.timeLabel.stringValue = "--"
            self.fileLabel.stringValue = ""
            self.audioMeter.display()
            
            let alert:NSAlert = NSAlert()
            alert.messageText = "Recording finished"
            alert.alertStyle = NSAlert.Style.informational
            alert.runModal()
            
        }
    }
    
    @IBAction func pauseRecording(_ sender: Any) {
        self.audioControl?.pauseRecord()
        self.pauseButton.isEnabled = false
        self.recordButton.isEnabled = true
    }
    
    func setupUpdateMeter() {
        self.timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        
        self.timer!.schedule(deadline: .now(), repeating: .microseconds(100))
        self.timer!.setEventHandler
        {
            self.timeLabel.stringValue = "\(Float(((self.audioControl?.getTime())!*10).rounded()/10))s"
            self.audioMeter.decibel = (self.audioControl?.getValue())!
            self.audioMeter.display()
        }
        self.timer!.resume()
        
    }
}
