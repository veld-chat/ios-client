//
//  UIImage.swift
//  chat (iOS)
//
//  Created by Mike  Veldsink on 26/12/2020.
//

import Foundation
import Cocoa

typealias UIImage = NSImage

extension NSImage {
    var cgImage: CGImage? {
        var proposedRect = CGRect(origin: .zero, size: size)

        return cgImage(forProposedRect: &proposedRect,
                       context: nil,
                       hints: nil)
    }

    convenience init?(named name: String) {
        self.init(named: Name(name))
    }
}
