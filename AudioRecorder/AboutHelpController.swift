//
//  AboutHelpController.swift
//  AudioRecorder
//
//  Created by Patrick Günthard on 13.11.18.
//  Copyright © 2018 Patrick Günthard. All rights reserved.
//

import Foundation
import Cocoa


class AboutController:NSViewController {
    
    @IBOutlet var image:NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.image = NSImageView(image: NSImage(byReferencingFile: "Images/256.png")!)
        self.image.display()
    }
}
