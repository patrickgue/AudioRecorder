//
//  AudioMeter.swift
//  AudioRecorder
//
//  Created by Patrick Günthard on 13.11.18.
//  Copyright © 2018 Patrick Günthard. All rights reserved.
//

import Foundation
import Cocoa

class AudioMeter: NSView{
    var decibel:Float = -120
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let context = NSGraphicsContext.current?.cgContext;
        
        
        /*context?.beginPath()
        context?.addRect(CGRect(x: 0, y: 0, width: 340, height: 150))
        context?.setFillColor(CGColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1))
        context?.fillPath()*/
        
        context!.beginPath()
        context!.move(to: CGPoint(x:170,y:10))
        let needleEnd = position(decibel: decibel, radius: 120)
        context!.addLine(to: CGPoint(x: 170 + needleEnd.x, y: 20 + needleEnd.y))
        context!.setStrokeColor(CGColor(red: 1,green: 0,blue: 0,alpha: 1))
        context!.setLineWidth(1.0)
        context!.strokePath()
        
        let atts = [
            NSAttributedString.Key.font:NSFont.init(name: "Helvetica", size: 14),
            NSAttributedString.Key.foregroundColor:NSColor.white
        ]
        ("dB" as NSString).draw(
            at: NSMakePoint(167,135),
            withAttributes: atts as [NSAttributedString.Key : Any])

        for dec in stride(from: -120, to: 1, by: 30) {
            let labelPosition = position(decibel: Float(dec), radius: 120)
            let atts = [
                NSAttributedString.Key.font:NSFont.init(name: "Helvetica", size: 10),
                NSAttributedString.Key.foregroundColor:NSColor.white
            ]
            ("\(dec)" as NSString).draw(
                at: NSMakePoint(CGFloat(165 + labelPosition.x),CGFloat(labelPosition.y)),
                withAttributes: atts as [NSAttributedString.Key : Any])
        }
        
        
    }
    
    func position(decibel:Float, radius:Int) -> (x:Int, y:Int){
        return (x: Int((decibel + 60) * Float(radius / 60)), y: Int(cos(((decibel + 60) * Float.pi) / 270) * Float(radius)))
    }
    
    
    
}
