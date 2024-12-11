//
//  UILabelExtension.swift
//  RBGViewer
//
//  Created by Alexey Kiparin on 11.12.2024.
//
import UIKit

extension UILabel {
	func hideAnimaited() {
		UIView.animate(withDuration: 0.2, animations: {
			self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
			self.isHidden = true
		})
	}
	
	func showAnimaited() {
		UIView.animate(withDuration: 0.2, animations: {
			self.isHidden = false
			self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
		})
	}
}
