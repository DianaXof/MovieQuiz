//
//  CustomButton.swift
//  MovieQuiz
//
//  Created by Diana Kondrashova on 29.07.2024.
//

import Foundation

import UIKit

class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 15.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            clipsToBounds = true
        }
    }
}
