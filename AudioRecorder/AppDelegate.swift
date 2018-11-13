//
//  AppDelegate.swift
//  AudioRecorder
//
//  Created by Patrick Günthard on 12.11.18.
//  Copyright © 2018 Patrick Günthard. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        //(NSApplication.shared.mainWindow?.windowController?.contentViewController as! ViewController).stopRecording(NSObject())
    }

    @IBAction func newRecording(_ sender: Any) {
        (NSApplication.shared.mainWindow?.windowController?.contentViewController as! ViewController).setPath(sender)
    }
    
    @IBAction func startRecording(_ sender: Any) {
        (NSApplication.shared.mainWindow?.windowController?.contentViewController as! ViewController).startRecording(sender)
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        (NSApplication.shared.mainWindow?.windowController?.contentViewController as! ViewController).stopRecording(sender)
    }
    
    @IBAction func showHelp(_ sender: Any) {
        
        let url = Bundle.main.url(forResource: "help", withExtension: "html")
        NSWorkspace.shared.open(url!)
        
    }
    
    @IBAction func customAboutPanel(_ sender: Any) {
        
    }
}

