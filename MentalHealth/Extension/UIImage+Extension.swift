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
    case soliuLogoOnly
    case selfTest
    case soliuLogo
    case right
    case rightArrow
    case home
    case account
    case dayButton
    case calendar
    case backArrow
}

enum Emotion: String {
    case star
}

enum SurveyImage: String {
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
        print("Can't load image")
        return UIImage()
    }
    
    convenience init?(assetIdentifier: SurveyImage) {
        let imagePath = "Icon/\(assetIdentifier.rawValue)"
        self.init(named: imagePath)
    }
    
    convenience init?(assetIdentifier: Image) {
        let imagePath = "Icon/\(assetIdentifier.rawValue)"
        self.init(named: imagePath)
    }
    
    convenience init?(emotionAssetIdentifier: Emotion) {
        let imagePath = "Icon/Emotion/\(emotionAssetIdentifier.rawValue)"
        self.init(named: imagePath)
    }

    func resized(toScale scale: CGFloat) -> UIImage {
           let newSize = CGSize(width: self.size.width * scale, height: self.size.height * scale)
           UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
           self.draw(in: CGRect(origin: .zero, size: newSize))
           let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           
           return resizedImage ?? self
    }

    func resizeTo(width: CGFloat, height: CGFloat) -> UIImage? {
        let newSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: .zero, size: newSize))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
