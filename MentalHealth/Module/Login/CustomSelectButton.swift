//
//  CustomSelectButton.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/24/24.
//

import Foundation
import UIKit

class CustomSelectButton: UIButton {
    private var buttonTappedCallback: ((Int, Bool) -> Void)?
    var checkmarkImageView: UIImageView?
    var index: Int

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    required init(titleString: String, index: Int, buttonTappedCallback: ((Int, Bool) -> Void)? = nil) {
        self.index = index
        super.init(frame: .zero)
        self.buttonTappedCallback = buttonTappedCallback
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.tabBarBorder.cgColor
        backgroundColor = .white
        setTitleColor(UIColor.soliuBlack, for: .normal)
        
        setTitle(titleString, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard !isSelected else {
            return
        }
        
        if isSelected {
            // Deselect the button
            isSelected = false
            defaultButtonSet()
            
            // Remove checkmark image
            checkmarkImageView?.removeFromSuperview()
        } else {
            // Select the button
            isSelected = true
            buttonTappedCallback?(index, isSelected)
            layer.borderWidth = 1.5
            layer.borderColor = UIColor.soliuBlue.cgColor
            setTitleColor(UIColor.soliuBlue, for: .normal)
            
            // Add checkmark image
            addCheckmarkImage()
            
            // Disable all other buttons
            guard let stackView = superview as? UIStackView else { return }
            for case let button as CustomSelectButton in stackView.arrangedSubviews where button != self {
                button.isSelected = false
                button.defaultButtonSet()
                button.checkmarkImageView?.removeFromSuperview()
            }
        }
    }
    
    func defaultButtonSet() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.tabBarBorder.cgColor
        setTitleColor(UIColor.soliuBlack, for: .normal)
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
