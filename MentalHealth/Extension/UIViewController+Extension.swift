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
    
    func createSelectButton(label: [String], spacing: CGFloat, constraintWith view: UIView) {
        var buttons: [UIButton] = []
        var userClicked = false

        for count in 0...label.count - 1 {
            let customButton = CustomButton(titleString: label[count]) { clicked in
                userClicked = clicked
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
        //return userClicked
    }
}

class CustomButton: UIButton {
    
    var defaultTitleColor: UIColor = .tabBarBorder
    var selectedTitleColor: UIColor = .soliuBlue
    var checkmarkImageView: UIImageView?
    
    private var buttonTappedCallback: ((Bool) -> Void)?

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    required init(titleString: String, buttonTappedCallback: ((Bool) -> Void)? = nil) {
        super.init(frame: .zero)
        self.buttonTappedCallback = buttonTappedCallback
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.tabBarBorder.cgColor
        backgroundColor = .white
        setTitleColor(defaultTitleColor, for: .normal)
        
        setTitle(titleString, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if isSelected {
            // Deselect the button
            isSelected = false
            defaultButtonSet()
            
            // Remove checkmark image
            checkmarkImageView?.removeFromSuperview()
        } else {
            // Select the button
            isSelected = true
            buttonTappedCallback?(isSelected)
            layer.borderWidth = 1.5
            layer.borderColor = selectedTitleColor.cgColor
            setTitleColor(selectedTitleColor, for: .normal)
            
            // Add checkmark image
            addCheckmarkImage()
            
            // Disable all other buttons
            guard let stackView = superview as? UIStackView else { return }
            for case let button as CustomButton in stackView.arrangedSubviews where button != self {
                button.isSelected = false
                button.defaultButtonSet()
                button.checkmarkImageView?.removeFromSuperview()
            }
        }
    }
    
    func defaultButtonSet() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.tabBarBorder.cgColor
        setTitleColor(defaultTitleColor, for: .normal)
    }
    
    func addCheckmarkImage() {
        let imageSize: CGFloat = 16
        let image = UIImage(assetIdentifier: .buttonCheck)
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: bounds.width - imageSize - 15, y: (bounds.height - imageSize) / 2, width: imageSize, height: imageSize)
        addSubview(imageView)
        
        checkmarkImageView = imageView
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

extension UIViewController {
    func setCustomBackNavigationButton(_ selector: Selector = #selector(UINavigationController.popViewController(animated:))) {
        let backButton = UIBarButtonItem(image: UIImage(assetIdentifier: .backArrow),
                                      style: .plain,
                                      target: navigationController,
                                      action: selector)
        navigationItem.leftBarButtonItem = backButton
    }
}
