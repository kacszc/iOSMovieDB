//
//  UIView+Identifier.swift
//  iOSMovieDB
//
//  Created by Kacper Szczepankiewicz on 02/12/2023.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self.self)
    }
}

