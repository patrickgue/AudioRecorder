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
    var centerX:Int = 170
    var needlePositionY:Int = 10
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let context = NSGraphicsContext.current?.cgContext;
        
        drawText(text: "dB",x: 167, y: 140, fontSize: 10, color: NSColor.textColor)
        
        for dec in stride(from: -120, to: 1, by: 30) {
            let labelPosition = position(decibel: Float(dec), radius: 115)
            drawText(text: "\(dec)", x: 162 + labelPosition.x, y: 10+labelPosition.y, fontSize: 10, color: NSColor.textColor)
        }
        
        
        for dec in stride(from: -120, to: 1, by: 10) {
            let needleStart = position(decibel: Float(dec), radius: 100)
            let needleEnd = position(decibel: Float(dec), radius: 90)
            context!.beginPath()
            context!.move(to: CGPoint(x: centerX + needleStart.x, y: needlePositionY + needleStart.y))
            context!.addLine(to: CGPoint(x: centerX + needleEnd.x, y: needlePositionY + needleEnd.y))
            context!.setStrokeColor(NSColor.textColor.cgColor)
            
            context!.setLineWidth(1.5)
            context!.strokePath()
            
        }
        
        context!.beginPath()
        context!.move(to: CGPoint(x:centerX,y:10))
        let needleEnd = position(decibel: decibel, radius: 120)
        context!.addLine(to: CGPoint(x: centerX + needleEnd.x, y: needlePositionY + needleEnd.y))
        context!.setStrokeColor(CGColor(red: 1,green: 0,blue: 0,alpha: 1))
        context!.setLineWidth(1.0)
        context!.strokePath()
        
    }
    
    func position(decibel:Float, radius:Int) -> (x:Int, y:Int){
        return (
            x: Int((decibel + 60) * Float(Double(radius)/60.0)),
            y: Int(cos(((decibel + 60) * Float.pi) / 270) * Float(radius))
        )
    }
    
    func drawText(text:String, x:Int, y:Int, fontSize:Int,color:NSColor) {
        let atts = [
            NSAttributedString.Key.font: NSFont.systemFont(ofSize: CGFloat(fontSize)),
            NSAttributedString.Key.foregroundColor: color
        ]
        (text as NSString).draw(
            at: NSMakePoint(CGFloat(x), CGFloat(y)),
            withAttributes: atts as [NSAttributedString.Key : Any]
        )
    }
    
    
    
}
