//
//  UIViewController+Extension.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/3/24.
//

import UIKit

extension UIViewController {
    func applyBoader(_ view: [UIView], with color: UIColor = UIColor.viewBorder) {
        view.forEach { view in
            view.layer.borderColor = color.cgColor
            view.layer.cornerRadius = 12
            view.layer.borderWidth = 1
            view.backgroundColor = .clear
        }
    }
    func applyBoader(_ view: UIView, with color: UIColor = UIColor.viewBorder) {
        view.layer.borderColor = color.cgColor
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.backgroundColor = .clear
    }
}
