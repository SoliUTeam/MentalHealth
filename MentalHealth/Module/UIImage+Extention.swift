//
//  UIImage+Extention.swift
//  MentalHealth
//
//  Created by JungpyoHong on 2/5/24.
//

import Foundation
import UIKit

enum Image: String {
    case soliuLogo
    case survey_black
    case survey_white
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
