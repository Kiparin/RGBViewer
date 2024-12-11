//
//  UIViewControllerExtension.swift
//  RBGViewer
//
//  Created by Alexey Kiparin on 11.12.2024.
//

import UIKit

extension UIViewController {
	
	func registerForKeyboardNotifications(stackView: UIStackView) {
		NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
			self.keyboardWillShow(notification: notification, stackView: stackView)
		}
		
		NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
			self.keyboardWillHide(stackView: stackView)
		}
	}
	
	private func keyboardWillShow(notification: Notification, stackView: UIStackView) {
		if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardFrame = keyboardSize.cgRectValue
			let keyboardHeight = keyboardFrame.height
			
			UIView.animate(withDuration: 0.3) {
				stackView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
			}
		}
	}
	
	private func keyboardWillHide(stackView: UIStackView) {
		UIView.animate(withDuration: 0.3) {
			stackView.transform = .identity
		}
	}
	
	func unregisterForKeyboardNotifications() {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
	}
}
