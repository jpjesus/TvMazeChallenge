//
//  UView+Extensions.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation
import UIKit

extension UIView {
    
    func makeItCircular() {
        layoutIfNeeded()
        setupRoundedCorners(radius: min(frame.size.height, frame.size.width) / 2)
    }
    
    func setupRoundedCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func setupBorder(width: CGFloat = 1.0, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
