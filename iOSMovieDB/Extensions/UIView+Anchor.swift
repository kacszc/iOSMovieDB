//
//  UIView+Anchor.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 02/12/2023.
//

import UIKit

extension UIView {
    func anchor(to layoutGuide: UILayoutGuide, insets: UIEdgeInsets = .zero) {
        guard
            layoutGuide.owningView == self.superview
        else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top),
            leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -(insets.bottom)),
            rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -(insets.right))
        ])
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func anchorCenterX(to parentView: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: constant).isActive = true
    }
    
    func anchorCenterY(to parentView: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: parentView.centerYAnchor, constant: constant).isActive = true
    }
}
