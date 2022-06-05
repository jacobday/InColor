//
//  DrawingSettingsViewController.swift
//  InColor
//
//  Created by Evan Japundza on 4/15/22.
//
// Evan Japundza, evjapund - Eli Cohen, cohenelj - Jacob Day, day6 ---------- In Color ---------- 5/6/2022

import UIKit

class DrawingSettingsViewController: UIViewController, UIColorPickerViewControllerDelegate {
    private var appDelegate: AppDelegate?
    private var drawingData: DrawingDataModel?
    
    private var strokeColor: UIColor = .black
    private var strokeWidth: CGFloat = 1.0
    
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var colorControl: UISegmentedControl!
    
    @IBAction func selectStroke(_ sender: UISlider) {
        // Round value to 1 decimal place
        let sliderValue = CGFloat(round(sender.value * 10) / 10.0)
        
        // Set stroke width locally & in DrawingDataModel
        strokeWidth = sliderValue
        drawingData?.setStrokeWidth(width: sliderValue)
        
        // Update stroke width label
        sender.tintColor = strokeColor
        widthLabel.text = String(format: "%.1f", strokeWidth)
    }
    
    @IBAction func selectCustomColor(_ sender: Any) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        
        // Display color picker
        self.present(colorPicker, animated: true)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let pickerSelection = viewController.selectedColor
        
        if (colorControl.selectedSegmentIndex == 0) {
            // Set stroke color locally & in DrawingDataModel
            drawingData?.setStrokeColor(color: pickerSelection)
            strokeColor = pickerSelection
            
            // Update width slider color
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            // Set background color in DrawingDataModel
            drawingData?.setBackgroundColor(color: pickerSelection)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.drawingData = self.appDelegate?.drawingData
        
        widthSlider.tintColor = strokeColor
        widthSlider.value = Float(strokeWidth)
        widthLabel.text = String(format: "%.1f", strokeWidth)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        strokeColor = drawingData?.getStrokeColor() ?? .black
        strokeWidth = drawingData?.getStrokeWidth() ?? 1.0
        
        widthSlider.tintColor = strokeColor
        widthSlider.value = Float(strokeWidth)
        widthLabel.text = String(format: "%.1f", strokeWidth)
    }
    
    @IBAction func setColorBlue(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.blue)
            
            strokeColor = UIColor.blue
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.blue)
        }
    }
    
    @IBAction func setColorGreen(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.green)
            
            strokeColor = UIColor.green
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.green)
        }
    }
    
    @IBAction func setColorRed(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.red)
            
            strokeColor = UIColor.red
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.red)
        }
    }
    
    @IBAction func setColorPurple(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.purple)
            
            strokeColor = UIColor.purple
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.purple)
        }
    }
    
    @IBAction func setColorOrange(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.orange)
            
            strokeColor = UIColor.orange
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.orange)
        }
    }
    
    @IBAction func setColorYellow(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.yellow)
            
            strokeColor = UIColor.yellow
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.yellow)
        }
    }
    
    @IBAction func setColorGray(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.gray)
            
            strokeColor = UIColor.gray
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.gray)
        }
    }
    
    @IBAction func setColorBlack(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.black)
            
            strokeColor = UIColor.black
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.black)
        }
    }
    
    @IBAction func setColorTeal(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.systemTeal)
            
            strokeColor = UIColor.systemTeal
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.systemTeal)
        }
    }
    
    @IBAction func setColorBrown(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.brown)
            
            strokeColor = UIColor.brown
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.brown)
        }
    }
    
    @IBAction func setColorPink(_ sender: Any) {
        if (colorControl.selectedSegmentIndex == 0) {
            drawingData?.setStrokeColor(color: UIColor.systemPink)
            
            strokeColor = UIColor.systemPink
            widthSlider.tintColor = strokeColor
        } else if (colorControl.selectedSegmentIndex == 1) {
            drawingData?.setBackgroundColor(color: UIColor.systemPink)
        }
    }
}
