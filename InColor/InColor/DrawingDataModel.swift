//
//  DrawingDataModel.swift
//  InColor
//
//  Created by Jacob Day on 4/16/22.
//
// Evan Japundza, evjapund - Eli Cohen, cohenelj - Jacob Day, day6 ---------- In Color ---------- 5/6/2022

import UIKit

class DrawingDataModel {
    private var backgroundColor: UIColor = .white
    private var strokeColor: UIColor = .black
    private var strokeWidth: CGFloat = 1.0
        
    func setBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    func setStrokeColor(color: UIColor) {
        strokeColor = color
    }
    
    func setStrokeWidth(width: CGFloat) {
        strokeWidth = width
    }
    
    func getBackgroundColor() -> UIColor {
        return backgroundColor
    }
    
    func getStrokeColor() -> UIColor {
        return strokeColor
    }
    
    func getStrokeWidth() -> CGFloat {
        return strokeWidth
    }
    
    func reset() {
        backgroundColor = .white
        strokeColor = .black
        strokeWidth = 1.0
    }
}
