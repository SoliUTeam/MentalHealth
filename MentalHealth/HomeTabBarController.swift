//
//  HomeTabBarController.swift
//  MentalHealth
//
//  Created by JungpyoHong on 3/18/24.
//

import UIKit
import Foundation

class HomeTabBarController: UITabBarController {
    
    var upperLineView: UIView!
    
    let spacing: CGFloat = 12

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.addTabBarIndicatorView(index: 0, isFirstTime: true)
        }
    }
    
    ///Add tabBar item indicator upper line
    func addTabBarIndicatorView(index: Int, isFirstTime: Bool = false){
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
            return
        }
        if !isFirstTime{
            upperLineView.removeFromSuperview()
        }
        upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y: tabView.frame.minY + 0.1, width: tabView.frame.size.width - spacing * 2, height: 4))
        upperLineView.backgroundColor = UIColor.systemBlue
        tabBar.addSubview(upperLineView)
    }

}

extension HomeTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabBarIndicatorView(index: self.selectedIndex)
    }
}

@IBDesignable class TabBarWithCorners: UITabBar {
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 18
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.shadowColor = UIColor.lightGray.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -2);
        shapeLayer.shadowOpacity = 0.21
        shapeLayer.shadowRadius = 8
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: radii).cgPath
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radii, height: 0.0))
        return path.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        let window = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last
        let bottomPadding = window?.safeAreaInsets.bottom
        tabFrame.size.height = 65 + (bottomPadding ?? 0)
        tabFrame.origin.y = self.frame.origin.y + self.frame.height - 65 - (bottomPadding ?? 0)
        self.layer.cornerRadius = 18
        self.frame = tabFrame
        self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })
    }
}
