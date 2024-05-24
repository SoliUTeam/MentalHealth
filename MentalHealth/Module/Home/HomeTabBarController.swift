//
//  HomeTabBarController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 4/11/24.
//

import Foundation
import UIKit

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupMiddleButton()
   }

    func setupMiddleButton() {
        
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-29, y: -15, width: 58, height: 58))
        
        middleBtn.setImage(UIImage(assetIdentifier: .dayUnClick), for: .normal)
        middleBtn.setImage(UIImage(assetIdentifier: .dayClick), for: .selected)
        middleBtn.isSelected = selectedIndex == 1
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        if selectedIndex != 1 {
            selectedIndex = 1
            sender.isSelected = true
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let middleBtn = self.tabBar.subviews.first(where: { $0 is UIButton }) as? UIButton {
            middleBtn.isSelected = selectedIndex == 1
        }
    }
}
