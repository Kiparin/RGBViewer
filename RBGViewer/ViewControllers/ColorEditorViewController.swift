//
//  ViewController.swift
//  RBGViewer
//
//  Created by Alexey Kiparin on 26.11.2024.
//

import UIKit

final class ColorEditorViewController: UIViewController {
	
	//MARK: - Outlets fields
	
	@IBOutlet weak var colorView: UIView!
	
	@IBOutlet weak var editPanelStackView: UIStackView!
	
	@IBOutlet weak var redRGBCount: UILabel!
	@IBOutlet weak var greenRGBCount: UILabel!
	@IBOutlet weak var blueRGBCount: UILabel!
	@IBOutlet weak var hexColorLabel: UILabel!
	
	@IBOutlet weak var redSlider: UISlider!
	@IBOutlet weak var greenSlider: UISlider!
	@IBOutlet weak var blueSlider: UISlider!
	
	@IBOutlet weak var blueText: UITextField!
	@IBOutlet weak var greenText: UITextField!
	@IBOutlet weak var redText: UITextField!
	
	//MARK: - UI fields
	
	var delegate: ColorViewControllerDelegate?
	var rgb: RGB?
	
	//MARK: - Override func
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		colorView.layer.cornerRadius = colorView.frame.height / 10
		registerForKeyboardNotifications(stackView: editPanelStackView) // регистрирую стек для анимации движения вместе с клавиатурой (так как я сам себе злобный буратино, пришлось гуглить)
		
		checkRGB() // проверяем, сущесвтует ли модель. Предусмотренна работа даже если нам ничего не передели
		setDelegates()
		update()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	
	//MARK: - IB Action
	
	@IBAction func sliderDidAction(_ sender: UISlider) {
		switch sender.tag {
		case 1:
			rgb?.red = sender.value
		case 2:
			rgb?.green = sender.value
		default:
			rgb?.blue = sender.value
		}
		update()
	}
	
	@IBAction func doneEditAction() {
		delegate?.appyColor(rgb)
		dismiss(animated: true)
	}
	
	//MARK: - Private func
	
	private func update() {
		updateTextValue()
		updateView()
		updateSliders()
	}
	
	private func updateTextValue() {
		redRGBCount.text = String(format: "%.*f", 2, rgb?.red ?? 0)
		redText.text = String(format: "%.*f", 2, rgb?.red ?? 0)
		
		greenRGBCount.text = String(format: "%.*f", 2, rgb?.green ?? 0)
		greenText.text = String(format: "%.*f", 2, rgb?.green ?? 0)
		
		blueRGBCount.text = String(format: "%.*f", 2, rgb?.blue ?? 0)
		blueText.text = String(format: "%.*f", 2, rgb?.blue ?? 0)
	}
	
	private func updateSliders() {
		redSlider.setValue(rgb?.red ?? 0, animated: true)
		greenSlider.setValue(rgb?.green ?? 0, animated: true)
		blueSlider.setValue(rgb?.blue ?? 0, animated: true)
	}
	
	private func updateView() {
		let color = UIColor(rgb)
		colorView.backgroundColor = color
		hexColorLabel.text = color.toHexString()
	}
	
	private func checkRGB() {
		if rgb == nil {
			rgb = RGB(red: 0, green: 0, blue: 0)
		}
	}
	
	private func setDelegates() {
		blueText.delegate = self
		greenText.delegate = self
		redText.delegate = self
	}
	
	deinit {
		unregisterForKeyboardNotifications()
	}
}

//MARK: EXTENSION
extension ColorEditorViewController : UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard let value = Float(textField.text ?? "-1") else {
			sendAlert()
			return
		}
		
		if value < 0 || value > 1 {
			sendAlert()
			return
		}
		
		switch textField.tag {
		case 11:
			rgb?.red = value
		case 12:
			rgb?.green = value
		default:
			rgb?.blue = value
		}
		
		hexColorLabel.showAnimaited()
		update()
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		hexColorLabel.hideAnimaited()
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	private func sendAlert() {
		let alert = UIAlertController(title: "Error", message: "Invalid value", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default){ _ in
			self.update()
		})
		present(alert, animated: true)
	}
}
