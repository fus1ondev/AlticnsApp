//
//  Application.swift
//  AlticnsApp
//
//  Created by Fus1onDev on 2022/11/14.
//

import Cocoa

class Application {
    let url: URL
    let icon: NSImage?
    let name: String
    
    init(url: URL) {
        let resourceValues = try? url.resourceValues(forKeys: [.effectiveIconKey])
        
        self.url = url
        self.icon = resourceValues?.effectiveIcon as? NSImage ?? NSImage()
        self.name = url.lastPathComponent
    }
}
