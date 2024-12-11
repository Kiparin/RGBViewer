//
//  ColorViewController.swift
//  RBGViewer
//
//  Created by Alexey Kiparin on 11.12.2024.
//

import UIKit

//MARK: - Protocol
protocol ColorViewControllerDelegate: AnyObject {
	func appyColor(_ rgb: RGB?)
}

//MARK: - UI
final class ColorViewController: UIViewController {

	var rgb: RGB? = .init(red: 0, green: 0, blue: 0)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		appyColor(rgb)
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let controller = segue.destination as? ColorEditorViewController else { return }
		controller.delegate = self
		controller.rgb = rgb
	}
	
}

//MARK: - Extension
extension ColorViewController: ColorViewControllerDelegate {
	func appyColor(_ rgb: RGB?) {
		view.backgroundColor = UIColor(rgb)
		self.rgb = rgb
	}
}
