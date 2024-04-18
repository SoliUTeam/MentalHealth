//
//  UIViewController+Extension.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/3/24.
//

import UIKit
import SwiftEntryKit

extension UIViewController {
    func applyBoader(_ view: [UIView], with color: UIColor = UIColor.viewBorder, backgroundColor: UIColor = .clear) {
        view.forEach { view in
            view.layer.borderColor = color.cgColor
            view.layer.cornerRadius = 12
            view.layer.borderWidth = 1
            view.backgroundColor = backgroundColor
        }
    }

    func applyBoader(_ view: UIView, with color: UIColor = UIColor.viewBorder, backgroundColor: UIColor = .clear) {
        view.layer.borderColor = color.cgColor
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.backgroundColor = backgroundColor
    }

    func makeCircleShape(_ view: UIView) {
        view.layer.cornerRadius = view.layer.frame.size.width/2
    }

    func getCurrentMonthAndDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthName = dateFormatter.string(from: currentDate)
        let calendar = Calendar.current
        let day = calendar.component(.day, from: currentDate)
        return "\(monthName) \(day)"
    }

    func getCurrentDate() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: currentDate)
        return "\(day)"
    }

    func getCurrentWeekday() -> String {
        let index = Calendar.current.component(.weekday, from: Date())
        return String(Calendar.current.weekdaySymbols[index].first!)
    }
}

extension UIViewController {
    func tapAction(_ view: UIView, selector: Selector) {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: selector)
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
}

extension UIViewController {
    func showAlert(title: String, description: String) {
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = .color(color: .white)
        attributes.displayDuration = 3
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.width), height: .intrinsic)
        
        let title = EKProperty.LabelContent(text: title, style: .init(font: .boldSystemFont(ofSize: 16), color: .black))
        let description = EKProperty.LabelContent(text: description, style: .init(font: .boldSystemFont(ofSize: 16), color: .black))
        let image = EKProperty.ImageContent(image: UIImage(assetIdentifier: .soliuLogoOnly)!, size: CGSize(width: 30, height: 35))
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
