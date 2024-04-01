//
//  UIImage+Extension.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/5/24.
//

import Foundation
import UIKit

enum Image: String {
    case oldSoliuLogo
    case soliuLogo
    case survey_black
    case survey_white
    case right
    case home
    case account
    case unmarkedVRare
    case unmarkedRare
    case unmarkedSometimes
    case unmarkedOften
    case unmarkedVOften
    case markedVRare
    case markedRare
    case markedSometimes
    case markedOften
    case markedVOften
}

extension UIImage {
    static func getImage(_ image: Image) -> UIImage {
        if let image = UIImage(named: image.rawValue) {
            return image
        }
        //TODO: This need to be proper error handling
        return UIImage()
    }
}

extension UIImage {
    func resizeTo(width: CGFloat, height: CGFloat) -> UIImage? {
        let newSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: .zero, size: newSize))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
