//
//  UIViewController+Extension.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/3/24.
//

import UIKit
import SwiftEntryKit

/// General Extension
extension UIViewController {
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

/// Navigation Extension
extension UIViewController {
    func tapAction(_ view: UIView, selector: Selector) {
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: selector)
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
}

/// UI Extension
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
    
    func createSelectButton(label: [String], spacing: CGFloat, constraintWith view: UIView, buttonTappedCallback: ((Int, Bool) -> Void)? = nil) {
        var buttons: [UIButton] = []
        var userClicked = false
        var index = 0

        for count in 0...label.count - 1 {
            let customButton = CustomSelectButton(titleString: label[count], index: count) { buttonIndex, isEnabled in
                index = buttonIndex
                userClicked = isEnabled
                buttonTappedCallback?(index, userClicked)
            }
            customButton.frame.size.height = 50
            buttons.append(customButton)
        }
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.distribution = .fillEqually
        addSubView(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: calculateStackViewHeight(count: label.count)).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        
        //Set Button Height to 40
        func calculateStackViewHeight(count: Int, buttonHeight height: Int = 40) -> CGFloat {
            CGFloat((count * height) + (10 * (count - 1)))
        }
    }
}

extension UIViewController {
    func addSubView(_ view: [UIView]) {
        view.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }
    }
    
    func addSubView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
    }
}

/// Set Navigation Back Button Extension
extension UIViewController {
    func setCustomBackNavigationButton(_ selector: Selector = #selector(UINavigationController.popViewController(animated:))) {
        let backButton = UIBarButtonItem(image: UIImage(assetIdentifier: .backArrow),
                                      style: .plain,
                                      target: navigationController,
                                      action: selector)
        navigationItem.leftBarButtonItem = backButton
    }
}
