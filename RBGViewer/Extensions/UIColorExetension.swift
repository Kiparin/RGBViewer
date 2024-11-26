//
//  UIColorExetension.swift
//  RBGViewer
//
//  Created by Alexey Kiparin on 27.11.2024.
//
import UIKit

extension UIColor {
    func toHexString() -> String {
        let components = self.cgColor.components ?? [0, 0, 0, 1]
        let r = components[0]
        let g = components[1]
        let b = components[2]
        
        let hexString = String(format: "#%02X%02X%02X",
                               Int(r * 255.0),
                               Int(g * 255.0),
                               Int(b * 255.0))
        return hexString
    }
}
