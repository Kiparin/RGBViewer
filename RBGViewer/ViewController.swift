//
//  ViewController.swift
//  RBGViewer
//
//  Created by Alexey Kiparin on 26.11.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redRGBCount: UILabel!
    @IBOutlet weak var greenRGBCount: UILabel!
    @IBOutlet weak var blueRGBCount: UILabel!
    @IBOutlet weak var hexColorLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = colorView.frame.height / 10
        
        didEditingColorViewAction()
    }
    
    @IBAction func sliderDidAction(_ sender: UISlider) {
        switch sender.tag {
        case 1:
            redRGBCount.text = String(format: "%.*f", 2, sender.value)
        case 2:
            greenRGBCount.text = String(format: "%.*f", 2, sender.value)
        case 3:
            blueRGBCount.text = String(format: "%.*f", 2, sender.value)
        default:
            break
        }
    }
    
    @IBAction func didEditingColorViewAction() {
        let color = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        colorView.backgroundColor = color
        hexColorLabel.text = color.toHexString()
    }
    
}

